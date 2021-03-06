﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml;
using Shoko.Commons.Queue;
using Shoko.Models.Queue;
using Shoko.Models.Server;
using Shoko.Server.Extensions;
using Shoko.Server.Models;
using Shoko.Server.Repositories;

namespace Shoko.Server.Commands
{
    [Serializable]
    public class CommandRequest_UpdateMyListFileStatus : CommandRequest_AniDBBase
    {
        public virtual string FullFileName { get; set; }
        public virtual string Hash { get; set; }
        public virtual bool Watched { get; set; }
        public virtual bool UpdateSeriesStats { get; set; }
        public virtual int WatchedDateAsSecs { get; set; }

        public override CommandRequestPriority DefaultPriority => CommandRequestPriority.Priority6;

        public override QueueStateStruct PrettyDescription => new QueueStateStruct
        {
            queueState = QueueStateEnum.UpdateMyListInfo,
            extraParams = new[] {FullFileName}
        };

        public CommandRequest_UpdateMyListFileStatus()
        {
        }

        public CommandRequest_UpdateMyListFileStatus(string hash, bool watched, bool updateSeriesStats,
            int watchedDateSecs)
        {
            Hash = hash;
            Watched = watched;
            CommandType = (int) CommandRequestType.AniDB_UpdateWatchedUDP;
            Priority = (int) DefaultPriority;
            UpdateSeriesStats = updateSeriesStats;
            WatchedDateAsSecs = watchedDateSecs;

            GenerateCommandID();
            FullFileName = RepoFactory.FileNameHash.GetByHash(Hash).FirstOrDefault()?.FileName;
        }

        public override void ProcessCommand()
        {
            logger.Info("Processing CommandRequest_UpdateMyListFileStatus: {0}", Hash);


            try
            {
                // NOTE - we might return more than one VideoLocal record here, if there are duplicates by hash
                SVR_VideoLocal vid = RepoFactory.VideoLocal.GetByHash(Hash);
                if (vid != null)
                {
                    bool isManualLink = false;
                    List<CrossRef_File_Episode> xrefs = vid.EpisodeCrossRefs;
                    if (xrefs.Count > 0)
                        isManualLink = xrefs[0].CrossRefSource != (int) CrossRefSource.AniDB;

                    if (isManualLink)
                    {
                        ShokoService.AnidbProcessor.UpdateMyListFileStatus(xrefs[0].AnimeID,
                            xrefs[0].GetEpisode().EpisodeNumber, Watched);
                        logger.Info("Updating file list status (GENERIC): {0} - {1}", vid, Watched);
                    }
                    else
                    {
                        if (WatchedDateAsSecs > 0)
                        {
                            DateTime? watchedDate = Commons.Utils.AniDB.GetAniDBDateAsDate(WatchedDateAsSecs);
                            ShokoService.AnidbProcessor.UpdateMyListFileStatus(vid, Watched, watchedDate);
                        }
                        else
                            ShokoService.AnidbProcessor.UpdateMyListFileStatus(vid, Watched, null);
                        logger.Info("Updating file list status: {0} - {1}", vid, Watched);
                    }

                    if (UpdateSeriesStats)
                    {
                        // update watched stats
                        List<SVR_AnimeEpisode> eps = RepoFactory.AnimeEpisode.GetByHash(vid.ED2KHash);
                        if (eps.Count > 0)
                        {
                            // all the eps should belong to the same anime
                            eps[0].GetAnimeSeries().QueueUpdateStats();
                            //eps[0].AnimeSeries.TopLevelAnimeGroup.UpdateStatsFromTopLevel(true, true, false);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                logger.Error("Error processing CommandRequest_UpdateMyListFileStatus: {0} - {1}", Hash, ex);
            }
        }

        /// <summary>
        /// This should generate a unique key for a command
        /// It will be used to check whether the command has already been queued before adding it
        /// </summary>
        public override void GenerateCommandID()
        {
            CommandID = $"CommandRequest_UpdateMyListFileStatus_{Hash}_{Guid.NewGuid().ToString()}";
        }

        public override bool InitFromDB(CommandRequest cq)
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
                Hash = TryGetProperty(docCreator, "CommandRequest_UpdateMyListFileStatus", "Hash");
                Watched = bool.Parse(
                    TryGetProperty(docCreator, "CommandRequest_UpdateMyListFileStatus", "Watched"));

                string sUpStats = TryGetProperty(docCreator, "CommandRequest_UpdateMyListFileStatus",
                    "UpdateSeriesStats");
                if (bool.TryParse(sUpStats, out bool upStats))
                    UpdateSeriesStats = upStats;

                if (
                    int.TryParse(
                        TryGetProperty(docCreator, "CommandRequest_UpdateMyListFileStatus", "WatchedDateAsSecs"),
                        out int dateSecs))
                    WatchedDateAsSecs = dateSecs;
                FullFileName = RepoFactory.FileNameHash.GetByHash(Hash).FirstOrDefault()?.FileName;
            }

            if (Hash.Trim().Length > 0)
                return true;
            return false;
        }
    }
}