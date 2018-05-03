﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml;
using NLog;
using Shoko.Commons.Queue;
using Shoko.Models.Queue;
using Shoko.Models.Server;
using Shoko.Server.Extensions;
using Shoko.Server.Models;
using Shoko.Server.Repositories;

namespace Shoko.Server.Commands
{
    [Serializable]
    public class CommandRequest_LinkFileManually : CommandRequest
    {
        private new static Logger logger = LogManager.GetCurrentClassLogger();

        public virtual int VideoLocalID { get; set; }
        public virtual int EpisodeID { get; set; }
        public virtual int Percentage { get; set; }

        private SVR_AnimeEpisode episode;
        private SVR_VideoLocal vlocal;

        public override CommandRequestPriority DefaultPriority => CommandRequestPriority.Priority3;

        public override QueueStateStruct PrettyDescription
        {
            get
            {
                if (vlocal != null && episode != null)
                    return new QueueStateStruct
                    {
                        queueState = QueueStateEnum.LinkFileManually,
                        extraParams = new[] {vlocal.FileName, episode.AniDB_Episode.EnglishName}
                    };
                return new QueueStateStruct
                {
                    queueState = QueueStateEnum.LinkFileManually,
                    extraParams = new[] {VideoLocalID.ToString(), EpisodeID.ToString()}
                };
            }
        }

        public CommandRequest_LinkFileManually()
        {
        }

        public CommandRequest_LinkFileManually(int vidLocalID, int episodeID)
        {
            VideoLocalID = vidLocalID;
            EpisodeID = episodeID;
            CommandType = (int) CommandRequestType.LinkFileManually;
            Priority = (int) DefaultPriority;

            GenerateCommandID();
        }

        public override void ProcessCommand()
        {
            List<CrossRef_File_Episode> fileEps = Repo.CrossRef_File_Episode.GetByHash(vlocal.Hash);

            foreach (CrossRef_File_Episode fileEp in fileEps)
                Repo.CrossRef_File_Episode.Delete(fileEp.CrossRef_File_EpisodeID);
            CrossRef_File_Episode xref = null;
            using (var cupd = Repo.CrossRef_File_Episode.BeginAdd())
            {
                try
                {
                cupd.Entity.PopulateManually_RA(vlocal, episode);
                }
                catch (Exception ex)
                {
                    logger.Error(ex, "Error populating XREF: {0}", vlocal.ToStringDetailed());
                    throw;
                }
                if (Percentage > 0 && Percentage <= 100)
                {
                    cupd.Entity.Percentage = Percentage;
                }

                xref=cupd.Commit();
            }

            CommandRequest_WebCacheSendXRefFileEpisode cr = new CommandRequest_WebCacheSendXRefFileEpisode(xref.CrossRef_File_EpisodeID);
            cr.Save();

            if (ServerSettings.FileQualityFilterEnabled)
            {
                List<SVR_VideoLocal> videoLocals = episode.GetVideoLocals();
                if (videoLocals != null)
                {
                    videoLocals.Sort(FileQualityFilter.CompareTo);
                    List<SVR_VideoLocal> keep = videoLocals.Take(FileQualityFilter.Settings.MaxNumberOfFilesToKeep)
                        .ToList();
                    foreach (SVR_VideoLocal vl2 in keep) videoLocals.Remove(vl2);
                    if (videoLocals.Contains(vlocal)) videoLocals.Remove(vlocal);
                    videoLocals = videoLocals.Where(FileQualityFilter.CheckFileKeep).ToList();

                    foreach (SVR_VideoLocal toDelete in videoLocals)
                    {
                        toDelete.Places.ForEach(a => a.RemoveAndDeleteFile());
                    }
                }
            }

            vlocal.Places.ForEach(a => { SVR_VideoLocal_Place.RenameAndMoveAsRequired(a); });

            
            SVR_AnimeSeries ser;
            using (var supd=Repo.AnimeSeries.BeginAddOrUpdate(()=> episode.GetAnimeSeries()))
            {
                supd.Entity.EpisodeAddedDate = DateTime.Now;
                ser=supd.Commit((false, true, false, false));
            }
            //Update will re-save
            ser.QueueUpdateStats();


            using (var gupd = Repo.AnimeGroup.BeginBatchUpdate(() => ser.AllGroupsAbove))
            {
                foreach (SVR_AnimeGroup grp in gupd)
                {
                    grp.EpisodeAddedDate = DateTime.Now;
                    gupd.Update(grp);
                }
                gupd.Commit((false, false, true));
            }
            if (ServerSettings.AniDB_MyList_AddFiles)
            {
                CommandRequest_AddFileToMyList cmdAddFile = new CommandRequest_AddFileToMyList(vlocal.Hash);
                cmdAddFile.Save();
            }
        }

        /// <summary>
        /// This should generate a unique key for a command
        /// It will be used to check whether the command has already been queued before adding it
        /// </summary>
        public override void GenerateCommandID()
        {
            CommandID = $"CommandRequest_LinkFileManually_{VideoLocalID}_{EpisodeID}";
        }

        public override bool InitFromDB(Shoko.Models.Server.CommandRequest cq)
        {
            CommandID = cq.CommandID;
            CommandRequestID = cq.CommandRequestID;
            CommandType = cq.CommandType;
            Priority = cq.Priority;
            CommandDetails = cq.CommandDetails;
            DateTimeUpdated = cq.DateTimeUpdated;

            // read xml to get parameters
            if (CommandDetails.Trim().Length > 0)
            {
                XmlDocument docCreator = new XmlDocument();
                docCreator.LoadXml(CommandDetails);

                // populate the fields
                VideoLocalID = int.Parse(TryGetProperty(docCreator, "CommandRequest_LinkFileManually", "VideoLocalID"));
                EpisodeID = int.Parse(TryGetProperty(docCreator, "CommandRequest_LinkFileManually", "EpisodeID"));
                Percentage = int.Parse(TryGetProperty(docCreator, "CommandRequest_LinkFileManually", "Percentage"));
                vlocal = Repo.VideoLocal.GetByID(VideoLocalID);
                if (null==vlocal)
                {
                    logger.Info("videolocal object {0} not found", VideoLocalID);
                    return false;
                }
                episode = Repo.AnimeEpisode.GetByID(EpisodeID);
            }

            return true;
        }
    }
}