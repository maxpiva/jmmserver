﻿using System;
using System.Collections.Generic;
using System.Xml;
using AniDBAPI;
using Shoko.Commons.Queue;
using Shoko.Models.Enums;
using Shoko.Models.Queue;
using Shoko.Models.Server;
using Shoko.Server.AniDB_API.Commands;
using Shoko.Server.AniDB_API.Raws;
using Shoko.Server.Repositories;

namespace Shoko.Server.Commands
{
    [Serializable]
    public class CommandRequest_SyncMyVotes : CommandRequest_AniDBBase
    {
        public override CommandRequestPriority DefaultPriority => CommandRequestPriority.Priority7;

        public override QueueStateStruct PrettyDescription => new QueueStateStruct
        {
            queueState = QueueStateEnum.Actions_SyncVotes,
            extraParams = new string[0]
        };


        public CommandRequest_SyncMyVotes()
        {
            CommandType = (int) CommandRequestType.AniDB_SyncVotes;
            Priority = (int) DefaultPriority;

            GenerateCommandID();
        }

        public override void ProcessCommand()
        {
            logger.Info("Processing CommandRequest_SyncMyVotes");

            try
            {
                AniDBHTTPCommand_GetVotes cmd = new AniDBHTTPCommand_GetVotes();
                cmd.Init(ServerSettings.AniDB_Username, ServerSettings.AniDB_Password);
                enHelperActivityType ev = cmd.Process();
                if (ev == enHelperActivityType.GotVotesHTTP)
                {
                    foreach (Raw_AniDB_Vote_HTTP myVote in cmd.MyVotes)
                    {
                        List<AniDB_Vote> dbVotes = RepoFactory.AniDB_Vote.GetByEntity(myVote.EntityID);
                        AniDB_Vote thisVote = null;
                        foreach (AniDB_Vote dbVote in dbVotes)
                        {
                            // we can only have anime permanent or anime temp but not both
                            if (myVote.VoteType == AniDBVoteType.Anime ||
                                myVote.VoteType == AniDBVoteType.AnimeTemp)
                            {
                                if (dbVote.VoteType == (int) AniDBVoteType.Anime ||
                                    dbVote.VoteType == (int) AniDBVoteType.AnimeTemp)
                                {
                                    thisVote = dbVote;
                                }
                            }
                            else
                            {
                                thisVote = dbVote;
                            }
                        }

                        if (thisVote == null)
                        {
                            thisVote = new AniDB_Vote
                            {
                                EntityID = myVote.EntityID
                            };
                        }
                        thisVote.VoteType = (int) myVote.VoteType;
                        thisVote.VoteValue = myVote.VoteValue;

                        RepoFactory.AniDB_Vote.Save(thisVote);

                        if (myVote.VoteType == AniDBVoteType.Anime || myVote.VoteType == AniDBVoteType.AnimeTemp)
                        {
                            // download the anime info if the user doesn't already have it
                            CommandRequest_GetAnimeHTTP cmdAnime = new CommandRequest_GetAnimeHTTP(thisVote.EntityID,
                                false, false);
                            cmdAnime.Save();
                        }
                    }

                    logger.Info("Processed Votes: {0} Items", cmd.MyVotes.Count);
                }
            }
            catch (Exception ex)
            {
                logger.Error("Error processing CommandRequest_SyncMyVotes: {0} ", ex);
            }
        }

        public override void GenerateCommandID()
        {
            CommandID = "CommandRequest_SyncMyVotes";
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
            }

            return true;
        }
    }
}