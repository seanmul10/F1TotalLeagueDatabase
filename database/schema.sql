CREATE TABLE IF NOT EXISTS "__EFMigrationsLock" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK___EFMigrationsLock" PRIMARY KEY,
    "Timestamp" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" TEXT NOT NULL CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY,
    "ProductVersion" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "CarClasses" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_CarClasses" PRIMARY KEY AUTOINCREMENT,
    "UniqueName" TEXT NULL,
    "Name" TEXT NULL,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "Games" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Games" PRIMARY KEY AUTOINCREMENT,
    "UniqueName" TEXT NULL,
    "Name" TEXT NULL,
    "Developer" TEXT NULL,
    "Publisher" TEXT NULL,
    "ReleaseDate" TEXT NOT NULL,
    "PlatformsRaw" TEXT NULL,
    "BuyLink" TEXT NULL,
    "OfficialLink" TEXT NULL,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "Images" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Images" PRIMARY KEY AUTOINCREMENT,
    "PngRaw" BLOB NULL,
    "Length" INTEGER NOT NULL,
    "Name" TEXT NULL,
    "NameUnique" TEXT NULL,
    "Type" TEXT NULL,
    "Hash" TEXT NULL,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "LeagueCategories" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_LeagueCategories" PRIMARY KEY AUTOINCREMENT,
    "Name" TEXT NULL,
    "ShortName" TEXT NULL,
    "Priority" INTEGER NOT NULL,
    "ColorRaw" INTEGER NOT NULL,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL
, "SecondaryColorRaw" INTEGER NOT NULL DEFAULT -1, "ColorString" TEXT NULL, "SecondaryColorString" TEXT NULL, "TertiaryColorString" TEXT NULL);
CREATE TABLE IF NOT EXISTS "LeagueSettings" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_LeagueSettings" PRIMARY KEY AUTOINCREMENT,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL,
    "Name" TEXT NULL,
    "Type" TEXT NULL,
    "Value" TEXT NULL
);
CREATE TABLE IF NOT EXISTS "Nationalities" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Nationalities" PRIMARY KEY AUTOINCREMENT,
    "Name" TEXT NOT NULL,
    "Code" TEXT NULL,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL
, "ColorString" TEXT NULL, "SecondaryColorString" TEXT NULL, "TertiaryColorString" TEXT NULL);
CREATE TABLE IF NOT EXISTS "Users" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Users" PRIMARY KEY AUTOINCREMENT,
    "Name" TEXT NULL,
    "Guid" TEXT NULL,
    "Password" TEXT NULL,
    "UserRole" INTEGER NOT NULL,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "PointActions" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_PointActions" PRIMARY KEY AUTOINCREMENT,
    "ActionType" INTEGER NOT NULL,
    "DriverPointsRaw" INTEGER NOT NULL,
    "TeamPointsRaw" INTEGER NOT NULL,
    "ChampionshipId" INTEGER NULL,
    "SessionType" INTEGER NOT NULL,
    "SessionPosition" INTEGER NULL,
    "RaceType" INTEGER NULL,
    "QualificationType" INTEGER NULL,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL, "ClassUniqueName" TEXT NULL,
    CONSTRAINT "FK_PointActions_Championships_ChampionshipId" FOREIGN KEY ("ChampionshipId") REFERENCES "Championships" ("Id") ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS "Tracks" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Tracks" PRIMARY KEY AUTOINCREMENT,
    "UniqueName" TEXT NOT NULL,
    "CircuitName" TEXT NULL,
    "CircuitFullName" TEXT NULL,
    "LocationName" TEXT NULL,
    "Years" TEXT NULL,
    "TrackLayout" INTEGER NOT NULL,
    "TrackType" INTEGER NOT NULL,
    "NationId" INTEGER NOT NULL,
    "Length" INTEGER NOT NULL,
    "NumberTurns" INTEGER NOT NULL,
    "RaceLapRecordTimeInt" INTEGER NOT NULL,
    "RaceLapRecordDriverName" TEXT NULL,
    "RaceLapRecordYear" INTEGER NOT NULL,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL, "AliasesRaw" TEXT NULL, "CircuitOrigin" TEXT NULL,
    CONSTRAINT "FK_Tracks_Nationalities_NationId" FOREIGN KEY ("NationId") REFERENCES "Nationalities" ("Id") ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS "Vendors" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Vendors" PRIMARY KEY AUTOINCREMENT,
    "UniqueName" TEXT NULL,
    "Name" TEXT NULL,
    "NationId" INTEGER NOT NULL,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL,
    CONSTRAINT "FK_Vendors_Nationalities_NationId" FOREIGN KEY ("NationId") REFERENCES "Nationalities" ("Id") ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS "SessionResults" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_SessionResults" PRIMARY KEY AUTOINCREMENT,
    "EventId" INTEGER NULL,
    "TrackId" INTEGER NULL,
    "SessionType" INTEGER NOT NULL,
    "RaceType" INTEGER NOT NULL,
    "QualType" INTEGER NOT NULL,
    "SessionPosition" INTEGER NOT NULL,
    "Date" TEXT NOT NULL,
    "SessionStatus" INTEGER NOT NULL,
    "SavedCompletedStatus" INTEGER NOT NULL,
    "IsSkip" INTEGER NOT NULL,
    "FastestLapDriverId" INTEGER NULL,
    "FastestLapDriverName" TEXT NULL,
    "FastestLapTimeInt" INTEGER NOT NULL,
    "FastestLapNumLap" INTEGER NOT NULL,
    "FastestLapValidFlags" INTEGER NOT NULL,
    "DriverDayDriverId" INTEGER NULL,
    "DriverDayDriverName" TEXT NULL,
    "BestMomentDriverId" INTEGER NULL,
    "BestMomentDriverName" TEXT NULL,
    "LiveId" INTEGER NOT NULL,
    "LiveStartDate" TEXT NOT NULL,
    "LiveEndDate" TEXT NOT NULL,
    "IsLiveSource" INTEGER NOT NULL,
    "IsLiveData" INTEGER NOT NULL,
    "LiveUserName" TEXT NULL,
    "MovedTargetSessionId" INTEGER NULL,
    "IsSingleplayerMode" INTEGER NOT NULL,
    "ChampionshipType" INTEGER NOT NULL,
    "GameType" INTEGER NOT NULL,
    "WeatherType" INTEGER NOT NULL,
    "AirTemperature" INTEGER NOT NULL,
    "TrackTemperature" INTEGER NOT NULL,
    "TotalLaps" INTEGER NOT NULL,
    "SessionDuration" TEXT NOT NULL,
    "SessionDetailsRaw" BLOB NULL,
    "QualificationType" INTEGER NOT NULL,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL, "IsLiveFullRecord" INTEGER NOT NULL DEFAULT 0, "LiveRecordPercent" INTEGER NOT NULL DEFAULT 0, "SessionCaptionUser" TEXT NULL, "TrackNameOrigin" TEXT NULL,
    CONSTRAINT "FK_SessionResults_Drivers_BestMomentDriverId" FOREIGN KEY ("BestMomentDriverId") REFERENCES "Drivers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_SessionResults_Drivers_DriverDayDriverId" FOREIGN KEY ("DriverDayDriverId") REFERENCES "Drivers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_SessionResults_Drivers_FastestLapDriverId" FOREIGN KEY ("FastestLapDriverId") REFERENCES "Drivers" ("Id") ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS "Events" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Events" PRIMARY KEY AUTOINCREMENT,
    "Name" TEXT NULL,
    "FullName" TEXT NULL,
    "ShortName" TEXT NULL,
    "TrackId" INTEGER NOT NULL,
    "Date" TEXT NOT NULL,
    "CompletedStatus" INTEGER NOT NULL,
    "EventStatus" INTEGER NOT NULL,
    "SeasonId" INTEGER NOT NULL,
    "Description" TEXT NULL,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL, "ColorRaw" INTEGER NOT NULL DEFAULT 0, "SecondaryColorRaw" INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT "FK_Events_Tracks_TrackId" FOREIGN KEY ("TrackId") REFERENCES "Tracks" ("Id") ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS "Cars" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Cars" PRIMARY KEY AUTOINCREMENT,
    "UniqueName" TEXT NULL,
    "Name" TEXT NULL,
    "CarClassId" INTEGER NOT NULL,
    "VendorId" INTEGER NULL,
    "Year" INTEGER NOT NULL,
    "Power" INTEGER NOT NULL,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL, "AliasesRaw" TEXT NULL, "ColorString" TEXT NULL, "SecondaryColorString" TEXT NULL, "TertiaryColorString" TEXT NULL,
    CONSTRAINT "FK_Cars_CarClasses_CarClassId" FOREIGN KEY ("CarClassId") REFERENCES "CarClasses" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_Cars_Vendors_VendorId" FOREIGN KEY ("VendorId") REFERENCES "Vendors" ("Id") ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS "Teams" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Teams" PRIMARY KEY AUTOINCREMENT,
    "Name" TEXT NOT NULL,
    "FullName" TEXT NULL,
    "UniqueName" TEXT NULL,
    "Abbreviation" TEXT NULL,
    "CarId" INTEGER NULL,
    "NationId" INTEGER NULL,
    "Position" INTEGER NULL,
    "ColorRaw" INTEGER NOT NULL,
    "Badge" TEXT NULL,
    "Prestige" INTEGER NOT NULL,
    "Year" INTEGER NOT NULL,
    "Seats" INTEGER NOT NULL,
    "PrevTeamId" INTEGER NULL,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL, "SecondaryColorRaw" INTEGER NOT NULL DEFAULT -1, "AliasesRaw" TEXT NULL, "ColorString" TEXT NULL, "SecondaryColorString" TEXT NULL, "TertiaryColorString" TEXT NULL,
    CONSTRAINT "FK_Teams_Cars_CarId" FOREIGN KEY ("CarId") REFERENCES "Cars" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_Teams_Nationalities_NationId" FOREIGN KEY ("NationId") REFERENCES "Nationalities" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_Teams_Teams_PrevTeamId" FOREIGN KEY ("PrevTeamId") REFERENCES "Teams" ("Id") ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS "DriverSessions" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_DriverSessions" PRIMARY KEY AUTOINCREMENT,
    "SessionResultId" INTEGER NOT NULL,
    "Position" INTEGER NOT NULL,
    "ClassificationPosition" INTEGER NOT NULL,
    "DriverId" INTEGER NULL,
    "DriverName" TEXT NULL,
    "TeamId" INTEGER NULL,
    "CarId" INTEGER NULL,
    "TeamName" TEXT NULL,
    "SeatType" INTEGER NOT NULL,
    "Status" INTEGER NOT NULL,
    "TimeInt" INTEGER NOT NULL,
    "GapInt" INTEGER NOT NULL,
    "StintsRaw" TEXT NULL,
    "FastestLapTimeInt" INTEGER NOT NULL,
    "FastestLapTyres" INTEGER NULL,
    "FastestLapNumLap" INTEGER NOT NULL,
    "FastestLapValidFlags" INTEGER NOT NULL,
    "PenaltySecsIngame" INTEGER NOT NULL,
    "PenaltyPosIngame" INTEGER NOT NULL,
    "PenaltySecsStewards" INTEGER NOT NULL,
    "PenaltyPosStewards" INTEGER NOT NULL,
    "PenaltyPoints" INTEGER NOT NULL,
    "DriverPointsRaw" INTEGER NOT NULL,
    "TeamPointsRaw" INTEGER NOT NULL,
    "IsLiveSource" INTEGER NOT NULL,
    "RaceNumber" INTEGER NOT NULL,
    "NationalityIngameId" INTEGER NOT NULL,
    "DriverNameIngame" TEXT NULL,
    "LapsCount" INTEGER NOT NULL,
    "GridPosition" INTEGER NOT NULL,
    "PitsCount" INTEGER NOT NULL,
    "DriverSessionsDetailsRaw" BLOB NULL,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL, "LiveId" INTEGER NULL, "WeakReferencesRaw" BLOB NULL, "PenaltyItemsRaw" BLOB NULL,
    CONSTRAINT "FK_DriverSessions_Cars_CarId" FOREIGN KEY ("CarId") REFERENCES "Cars" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_DriverSessions_Drivers_DriverId" FOREIGN KEY ("DriverId") REFERENCES "Drivers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_DriverSessions_Teams_TeamId" FOREIGN KEY ("TeamId") REFERENCES "Teams" ("Id") ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS "LineUps" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_LineUps" PRIMARY KEY AUTOINCREMENT,
    "LineupsBasedType" INTEGER NOT NULL,
    "SeatType" INTEGER NOT NULL,
    "TeamId" INTEGER NULL,
    "CarId" INTEGER NULL,
    "DriverId" INTEGER NULL,
    "SeatPosition" INTEGER NOT NULL,
    "ReservePosition" INTEGER NOT NULL,
    "Badge" TEXT NULL,
    "SeasonId" INTEGER NOT NULL,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL, "LiveryVariant" TEXT NULL, "DriverFeatures" INTEGER NULL,
    CONSTRAINT "FK_LineUps_Cars_CarId" FOREIGN KEY ("CarId") REFERENCES "Cars" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_LineUps_Drivers_DriverId" FOREIGN KEY ("DriverId") REFERENCES "Drivers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_LineUps_Seasons_SeasonId" FOREIGN KEY ("SeasonId") REFERENCES "Seasons" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_LineUps_Teams_TeamId" FOREIGN KEY ("TeamId") REFERENCES "Teams" ("Id") ON DELETE RESTRICT
);
CREATE INDEX "IX_Cars_CarClassId" ON "Cars" ("CarClassId");
CREATE INDEX "IX_Cars_VendorId" ON "Cars" ("VendorId");
CREATE INDEX "IX_DriverSessions_CarId" ON "DriverSessions" ("CarId");
CREATE INDEX "IX_DriverSessions_DriverId" ON "DriverSessions" ("DriverId");
CREATE INDEX "IX_DriverSessions_TeamId" ON "DriverSessions" ("TeamId");
CREATE INDEX "IX_Events_TrackId" ON "Events" ("TrackId");
CREATE INDEX "IX_LineUps_CarId" ON "LineUps" ("CarId");
CREATE INDEX "IX_LineUps_DriverId" ON "LineUps" ("DriverId");
CREATE INDEX "IX_LineUps_SeasonId" ON "LineUps" ("SeasonId");
CREATE INDEX "IX_LineUps_TeamId" ON "LineUps" ("TeamId");
CREATE INDEX "IX_PointActions_ChampionshipId" ON "PointActions" ("ChampionshipId");
CREATE INDEX "IX_SessionResults_BestMomentDriverId" ON "SessionResults" ("BestMomentDriverId");
CREATE INDEX "IX_SessionResults_DriverDayDriverId" ON "SessionResults" ("DriverDayDriverId");
CREATE INDEX "IX_SessionResults_FastestLapDriverId" ON "SessionResults" ("FastestLapDriverId");
CREATE INDEX "IX_Teams_CarId" ON "Teams" ("CarId");
CREATE INDEX "IX_Teams_NationId" ON "Teams" ("NationId");
CREATE INDEX "IX_Teams_PrevTeamId" ON "Teams" ("PrevTeamId");
CREATE INDEX "IX_Tracks_NationId" ON "Tracks" ("NationId");
CREATE INDEX "IX_Vendors_NationId" ON "Vendors" ("NationId");
CREATE TABLE IF NOT EXISTS "PenaltySystems" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_PenaltySystems" PRIMARY KEY AUTOINCREMENT,
    "Name" TEXT NULL,
    "DropPolicyType1" INTEGER NULL,
    "DropPolicyValue1" INTEGER NULL,
    "DropPolicyDropValue1" INTEGER NULL,
    "DropPolicyType2" INTEGER NULL,
    "DropPolicyValue2" INTEGER NULL,
    "DropPolicyDropValue2" INTEGER NULL,
    "DropPolicyType3" INTEGER NULL,
    "DropPolicyValue3" INTEGER NULL,
    "DropPolicyDropValue3" INTEGER NULL,
    "ApplyPenaltyPointsAfterWarningsReached" INTEGER NULL,
    "SumOfPenaltyPointsApplyingAfterWarnings" INTEGER NULL,
    "IsRemoveWarningsWhenPenaltyPointsWasRemoved" INTEGER NOT NULL,
    "PenaltyPointsArea" INTEGER NOT NULL,
    "IsConfirmFromUserWhenPenaltyActionRaised" INTEGER NOT NULL,
    "IsApplyAllChainOfThresholds" INTEGER NOT NULL,
    "IsApplyMultiplierForRepeatedPenalty" INTEGER NOT NULL,
    "PenaltyBackwardZone" INTEGER NULL,
    "PenaltyBackwardZoneValue" INTEGER NULL,
    "PenaltyMultiplier" INTEGER NULL,
    "PenaltyProgressiveMultiplier" INTEGER NULL,
    "IsAutoSaveOffenses" INTEGER NOT NULL,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL
, "CleanSessionDefinition" INTEGER NOT NULL DEFAULT 0, "IsAutoCancelPenaltyActionAfterRemoving" INTEGER NOT NULL DEFAULT 1, "IsConfirmFromUserWhenFutureActionApplyForDriverSession" INTEGER NOT NULL DEFAULT 1, "IsDisableProcessingFutureActionForLiveDriverSession" INTEGER NOT NULL DEFAULT 1, "IsEnableSilentModeWhenFutureActionApplyForLiveDriverSession" INTEGER NOT NULL DEFAULT 1, "IsExcludeArchiveDriversFromProcessing" INTEGER NOT NULL DEFAULT 1, "IsExcludeArchiveSeasonsFromArea" INTEGER NOT NULL DEFAULT 1, "IsExcludeCompletedSeasonsAfterStartCurrentForPenaltyActionsArea" INTEGER NOT NULL DEFAULT 0, "IsExcludeCompletedSeasonsAfterStartCurrentForPenaltyPointsArea" INTEGER NOT NULL DEFAULT 0, "IsExcludeCompletedSeasonsAfterStartCurrentForWarningsArea" INTEGER NOT NULL DEFAULT 0, "IsExcludeCompletedSeasonsBeforeStartCurrentForPenaltyActionsArea" INTEGER NOT NULL DEFAULT 0, "IsExcludeCompletedSeasonsBeforeStartCurrentForPenaltyPointsArea" INTEGER NOT NULL DEFAULT 0, "IsExcludeCompletedSeasonsBeforeStartCurrentForWarningsArea" INTEGER NOT NULL DEFAULT 0, "IsExcludeSeasonsStartedAfterOriginSeasonWasCompletedForFutureActions" INTEGER NOT NULL DEFAULT 0, "IsExcludeSeasonsWhereDriverIsNotLineupsForFutureActions" INTEGER NOT NULL DEFAULT 0, "IsExcludeSeasonsWhereDriverIsNotPrimaryLineupsForFutureActions" INTEGER NOT NULL DEFAULT 1, "IsIncludeAllDriversFromOtherSeasonsArea" INTEGER NOT NULL DEFAULT 1, "IsIncludeMinorRacesForActionsDriverSessionHistory" INTEGER NOT NULL DEFAULT 0, "IsIncludeNonChampSessionsForActionsDriverSessionHistory" INTEGER NOT NULL DEFAULT 0, "IsIncludeSafetyRacesForActionsDriverSessionHistory" INTEGER NOT NULL DEFAULT 0, "IsNotifyUserWhenFutureActionApplyForDriverSession" INTEGER NOT NULL DEFAULT 0, "IsRequireOtherSeasonsHaveSameArea" INTEGER NOT NULL DEFAULT 0, "IsUserChooseSeasonForPenaltyAction" INTEGER NOT NULL DEFAULT 0, "PenaltyActionsArea" INTEGER NOT NULL DEFAULT 0, "WarningsArea" INTEGER NOT NULL DEFAULT 0, "IsSetAsAppliedAllWarningsWhenLimitWasReached" INTEGER NOT NULL DEFAULT 1, "IsAutoSetAsAppliedManualFutureActions" INTEGER NOT NULL DEFAULT 1);
CREATE TABLE IF NOT EXISTS "PenaltyOffenses" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_PenaltyOffenses" PRIMARY KEY AUTOINCREMENT,
    "Position" INTEGER NOT NULL,
    "Paragraph" TEXT NULL,
    "Offense" TEXT NULL,
    "Description" TEXT NULL,
    "PenaltyPoints" INTEGER NOT NULL,
    "PenaltySeconds" INTEGER NOT NULL,
    "PenaltyPositions" INTEGER NOT NULL,
    "PenaltyWarnings" INTEGER NOT NULL,
    "PenaltyActionType" INTEGER NULL,
    "PenaltyActionValue" INTEGER NULL,
    "PenaltySystemId" INTEGER NULL,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL, "IsDisqualification" INTEGER NOT NULL DEFAULT 0, "PenaltyActionType2" INTEGER NULL, "PenaltyActionValue2" INTEGER NULL,
    CONSTRAINT "FK_PenaltyOffenses_PenaltySystems_PenaltySystemId" FOREIGN KEY ("PenaltySystemId") REFERENCES "PenaltySystems" ("Id") ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS "PenaltyPointsThresholds" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_PenaltyPointsThresholds" PRIMARY KEY AUTOINCREMENT,
    "PenaltySystemId" INTEGER NOT NULL,
    "Value" INTEGER NOT NULL,
    "Type" INTEGER NOT NULL,
    "PenaltyTypeValue" INTEGER NOT NULL,
    "AdditionalType" INTEGER NOT NULL,
    "AdditionalPenaltyTypeValue" INTEGER NOT NULL,
    "IsAutoApplying" INTEGER NOT NULL,
    "IsClearPenaltyPoints" INTEGER NOT NULL,
    "Description" TEXT NULL,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL,
    CONSTRAINT "FK_PenaltyPointsThresholds_PenaltySystems_PenaltySystemId" FOREIGN KEY ("PenaltySystemId") REFERENCES "PenaltySystems" ("Id") ON DELETE RESTRICT
);
CREATE INDEX "IX_PenaltyOffenses_PenaltySystemId" ON "PenaltyOffenses" ("PenaltySystemId");
CREATE INDEX "IX_PenaltyPointsThresholds_PenaltySystemId" ON "PenaltyPointsThresholds" ("PenaltySystemId");
CREATE TABLE IF NOT EXISTS "Championships" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Championships" PRIMARY KEY AUTOINCREMENT,
    "BaseChampionshipString" TEXT NULL,
    "CarsRaw" BLOB NULL,
    "CreatedAt" INTEGER NOT NULL,
    "DefaultCarId" INTEGER NULL,
    "DefaultCarStringId" TEXT NULL,
    "FastestLapPointsPositionEdge" INTEGER NOT NULL,
    "GamesRaw" BLOB NULL,
    "GridSize" INTEGER NOT NULL,
    "IgnoreWorstEventsEachDriver" INTEGER NOT NULL,
    "IsMinorRacesEqualsMajor" INTEGER NOT NULL,
    "LineupsBasedType" INTEGER NOT NULL,
    "Name" TEXT NULL,
    "PenaltySystemId" INTEGER NULL,
    "PracticesCount" INTEGER NOT NULL,
    "QualType1" INTEGER NOT NULL,
    "QualType2" INTEGER NOT NULL,
    "QualType3" INTEGER NOT NULL,
    "QualsCount" INTEGER NOT NULL,
    "RaceType1" INTEGER NOT NULL,
    "RaceType2" INTEGER NOT NULL,
    "RaceType3" INTEGER NOT NULL,
    "RacesCount" INTEGER NOT NULL,
    "SeatsPerTeam" INTEGER NOT NULL,
    "SeatsReserve" INTEGER NOT NULL,
    "TeamsRaw" BLOB NULL,
    "TracksRaw" BLOB NULL,
    "UniqueName" TEXT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL, "MaxTimePercentQualClassificationCriteria" INTEGER NOT NULL DEFAULT 0, "MinDistanceMetersRaceClassificationCriteria" INTEGER NOT NULL DEFAULT 0, "MinDistancePercentRaceClassificationCriteria" INTEGER NOT NULL DEFAULT 0, "MinLapsPercentRaceClassificationCriteria" INTEGER NOT NULL DEFAULT 0, "MinLapsRaceClassificationCriteria" INTEGER NOT NULL DEFAULT 0, "MinTimeMinutesRaceClassificationCriteria" INTEGER NOT NULL DEFAULT 0, "MinTimePercentRaceClassificationCriteria" INTEGER NOT NULL DEFAULT 0, "EventFormatJson" TEXT NULL, "MulticlassConfigurationJson" TEXT NULL,
    CONSTRAINT "FK_Championships_PenaltySystems_PenaltySystemId" FOREIGN KEY ("PenaltySystemId") REFERENCES "PenaltySystems" ("Id") ON DELETE RESTRICT
);
CREATE INDEX "IX_Championships_PenaltySystemId" ON "Championships" ("PenaltySystemId");
CREATE TABLE IF NOT EXISTS "PenaltyItems" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_PenaltyItems" PRIMARY KEY AUTOINCREMENT,
    "CarId" INTEGER NULL,
    "CreatedAt" INTEGER NOT NULL,
    "Date" TEXT NULL,
    "Description" TEXT NULL,
    "DriverId" INTEGER NOT NULL,
    "DriverSessionActionAppliedId" INTEGER NULL,
    "DriverSessionId" INTEGER NULL,
    "DriversInvolvedRaw" BLOB NULL,
    "IsCancelled" INTEGER NOT NULL,
    "IsCreatedByUser" INTEGER NOT NULL,
    "IsNoPunishment" INTEGER NOT NULL,
    "IsPenaltyActionApplied" INTEGER NULL,
    "IsPenaltyPointsApplied" INTEGER NOT NULL,
    "IsWarningsApplied" INTEGER NOT NULL,
    "IssuerId" INTEGER NULL,
    "Lap" TEXT NULL,
    "Offense" TEXT NULL,
    "PenaltyActionSourceDriverSessionId" INTEGER NULL,
    "PenaltyActionSourcePenaltyItemId" INTEGER NULL,
    "PenaltyActionType" INTEGER NULL,
    "PenaltyActionValue" INTEGER NULL,
    "PenaltyId" TEXT NULL,
    "PenaltyOffenseId" INTEGER NULL,
    "PenaltyPoints" INTEGER NOT NULL,
    "PenaltyPositions" INTEGER NOT NULL,
    "PenaltySeconds" INTEGER NOT NULL,
    "PenaltyWarnings" INTEGER NOT NULL,
    "SameOffenseRepeatedCount" INTEGER NULL,
    "SeasonId" INTEGER NULL,
    "SessionResultId" INTEGER NULL,
    "SubmitterId" INTEGER NULL,
    "TeamId" INTEGER NULL,
    "Turn" TEXT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL,
    "Verdict" TEXT NULL, "IsDisqualified" INTEGER NOT NULL DEFAULT 0, "SourcePenaltyActionId" INTEGER NULL, "SourcePenaltyItemId" INTEGER NULL, "SourcePenaltyThresholdId" INTEGER NULL, "WarningsAppliedCount" INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT "FK_PenaltyItems_Cars_CarId" FOREIGN KEY ("CarId") REFERENCES "Cars" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_PenaltyItems_DriverSessions_DriverSessionActionAppliedId" FOREIGN KEY ("DriverSessionActionAppliedId") REFERENCES "DriverSessions" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_PenaltyItems_DriverSessions_DriverSessionId" FOREIGN KEY ("DriverSessionId") REFERENCES "DriverSessions" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_PenaltyItems_Drivers_DriverId" FOREIGN KEY ("DriverId") REFERENCES "Drivers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_PenaltyItems_Drivers_IssuerId" FOREIGN KEY ("IssuerId") REFERENCES "Drivers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_PenaltyItems_Drivers_SubmitterId" FOREIGN KEY ("SubmitterId") REFERENCES "Drivers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_PenaltyItems_PenaltyOffenses_PenaltyOffenseId" FOREIGN KEY ("PenaltyOffenseId") REFERENCES "PenaltyOffenses" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_PenaltyItems_Seasons_SeasonId" FOREIGN KEY ("SeasonId") REFERENCES "Seasons" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_PenaltyItems_SessionResults_SessionResultId" FOREIGN KEY ("SessionResultId") REFERENCES "SessionResults" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_PenaltyItems_Teams_TeamId" FOREIGN KEY ("TeamId") REFERENCES "Teams" ("Id") ON DELETE RESTRICT
);
CREATE INDEX "IX_PenaltyItems_CarId" ON "PenaltyItems" ("CarId");
CREATE INDEX "IX_PenaltyItems_DriverId" ON "PenaltyItems" ("DriverId");
CREATE INDEX "IX_PenaltyItems_DriverSessionActionAppliedId" ON "PenaltyItems" ("DriverSessionActionAppliedId");
CREATE INDEX "IX_PenaltyItems_DriverSessionId" ON "PenaltyItems" ("DriverSessionId");
CREATE INDEX "IX_PenaltyItems_IssuerId" ON "PenaltyItems" ("IssuerId");
CREATE INDEX "IX_PenaltyItems_PenaltyOffenseId" ON "PenaltyItems" ("PenaltyOffenseId");
CREATE INDEX "IX_PenaltyItems_SeasonId" ON "PenaltyItems" ("SeasonId");
CREATE INDEX "IX_PenaltyItems_SessionResultId" ON "PenaltyItems" ("SessionResultId");
CREATE INDEX "IX_PenaltyItems_SubmitterId" ON "PenaltyItems" ("SubmitterId");
CREATE INDEX "IX_PenaltyItems_TeamId" ON "PenaltyItems" ("TeamId");
CREATE TABLE IF NOT EXISTS "DatabaseChanges" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_DatabaseChanges" PRIMARY KEY AUTOINCREMENT,
    "Change" TEXT NULL,
    "Method" INTEGER NOT NULL,
    "IsLocalChange" INTEGER NOT NULL,
    "DatabaseCategory" INTEGER NOT NULL,
    "LeagueCategoriesRaw" BLOB NULL,
    "SeasonId" INTEGER NULL,
    "SessionResultId" INTEGER NULL,
    "DriverId" INTEGER NULL,
    "UserName" TEXT NULL,
    "UniqueId" TEXT NULL,
    "AltVersion" INTEGER NOT NULL,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "LeagueRoles" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_LeagueRoles" PRIMARY KEY AUTOINCREMENT,
    "Name" TEXT NULL,
    "ColorRaw" INTEGER NOT NULL,
    "SecondaryColorRaw" INTEGER NOT NULL,
    "LeagueRoleBuiltIn" INTEGER NULL,
    "Priority" INTEGER NOT NULL,
    "DatabaseCategoriesAllowedRaw" INTEGER NOT NULL,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL
, "ColorString" TEXT NULL, "SecondaryColorString" TEXT NULL, "TertiaryColorString" TEXT NULL);
CREATE TABLE IF NOT EXISTS "Seasons" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Seasons" PRIMARY KEY AUTOINCREMENT,
    "ChampionshipId" INTEGER NULL,
    "CreatedAt" INTEGER NOT NULL,
    "DaysBetweenEvents" INTEGER NOT NULL,
    "DriverPointsSpecialRaw" BLOB NULL,
    "FullName" TEXT NULL,
    "GridSize" INTEGER NOT NULL,
    "IgnoreWorstEventsEachDriver" INTEGER NOT NULL,
    "IgnoreWorstEventsEachTeam" INTEGER NOT NULL,
    "IsArchive" INTEGER NOT NULL,
    "IsDnfDriversCanBeClassified" INTEGER NOT NULL,
    "IsExcludeReservesFromClassification" INTEGER NOT NULL,
    "IsReserveBringTeamPoints" INTEGER NOT NULL,
    "IsSeparateReservesAtStandings" INTEGER NOT NULL,
    "IsShowTimesInsteadGapInQual" INTEGER NOT NULL,
    "IsStandingsShowAllLineups" INTEGER NOT NULL,
    "IsStandingsShowArchiveDrivers" INTEGER NOT NULL,
    "IsStandingsShowReserves" INTEGER NOT NULL,
    "LeagueCategoriesRaw" BLOB NULL,
    "LeagueCategoryId" INTEGER NULL,
    "LimitNumberDriversOnStandings" INTEGER NOT NULL,
    "LineupsBasedType" INTEGER NOT NULL,
    "Name" TEXT NULL,
    "PenaltySystemId" INTEGER NULL,
    "PracticesCount" INTEGER NOT NULL,
    "Priority" INTEGER NOT NULL,
    "QualType1" INTEGER NOT NULL,
    "QualType2" INTEGER NOT NULL,
    "QualType3" INTEGER NOT NULL,
    "QualsCount" INTEGER NOT NULL,
    "RaceType1" INTEGER NOT NULL,
    "RaceType2" INTEGER NOT NULL,
    "RaceType3" INTEGER NOT NULL,
    "RacesCount" INTEGER NOT NULL,
    "ReserveProcessingMode" INTEGER NOT NULL,
    "SeatsPerTeam" INTEGER NOT NULL,
    "SeatsReserve" INTEGER NOT NULL,
    "StartIgnoreWorstEventsAfterPercent" INTEGER NOT NULL,
    "TeamPointsSpecialRaw" BLOB NULL,
    "TimeOffsetType" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL, "ColorRaw" INTEGER NOT NULL DEFAULT 0, "SecondaryColorRaw" INTEGER NOT NULL DEFAULT 0, "DiscardWorstEventsValueForEachDriver" INTEGER NOT NULL DEFAULT 0, "DiscardWorstEventsValueForEachTeam" INTEGER NOT NULL DEFAULT 0, "IsDiscardWorstEventsForEachDriver" INTEGER NOT NULL DEFAULT 0, "IsDiscardWorstEventsForEachTeam" INTEGER NOT NULL DEFAULT 0, "IsDiscardWorstEventsIncludeTeamForEachDriver" INTEGER NOT NULL DEFAULT 0, "IsDiscardWorstEventsStatisticsTooForEachDriver" INTEGER NOT NULL DEFAULT 0, "IsDiscardWorstEventsStatisticsTooForEachTeam" INTEGER NOT NULL DEFAULT 0, "IsDiscardWorstRacesIncludeMinorTypesForEachDriver" INTEGER NOT NULL DEFAULT 0, "IsDiscardWorstRacesIncludeMinorTypesForEachTeam" INTEGER NOT NULL DEFAULT 0, "IsDiscardWorstRacesInsteadEventsForEachDriver" INTEGER NOT NULL DEFAULT 0, "IsDiscardWorstRacesInsteadEventsForEachTeam" INTEGER NOT NULL DEFAULT 0, "MaxTimePercentQualClassificationCriteria" INTEGER NOT NULL DEFAULT 0, "MinDistanceMetersRaceClassificationCriteria" INTEGER NOT NULL DEFAULT 0, "MinDistancePercentRaceClassificationCriteria" INTEGER NOT NULL DEFAULT 0, "MinLapsPercentRaceClassificationCriteria" INTEGER NOT NULL DEFAULT 0, "MinLapsRaceClassificationCriteria" INTEGER NOT NULL DEFAULT 0, "MinTimeMinutesRaceClassificationCriteria" INTEGER NOT NULL DEFAULT 0, "MinTimePercentRaceClassificationCriteria" INTEGER NOT NULL DEFAULT 0, "StartDiscardWorstEventsAfterPercentForEachDriver" INTEGER NOT NULL DEFAULT 0, "StartDiscardWorstEventsAfterPercentForEachTeam" INTEGER NOT NULL DEFAULT 0, "ActiveEventSessionPresetId" TEXT NULL, "DefaultEventStartTime" TEXT NOT NULL DEFAULT '00:00:00', "EventFormatJson" TEXT NULL, "IsEventDateOnly" INTEGER NOT NULL DEFAULT 0, "IsSessionDateOnly" INTEGER NOT NULL DEFAULT 0, "MulticlassConfigurationJson" TEXT NULL, "TimeAttackDiscardBestSessionsCount" INTEGER NOT NULL DEFAULT 0, "TimeAttackDiscardWorstSessionsCount" INTEGER NOT NULL DEFAULT 0, "TimeAttackMinParticipationPercent" INTEGER NOT NULL DEFAULT 0, "ColorString" TEXT NULL, "SecondaryColorString" TEXT NULL, "TertiaryColorString" TEXT NULL,
    CONSTRAINT "FK_Seasons_Championships_ChampionshipId" FOREIGN KEY ("ChampionshipId") REFERENCES "Championships" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_Seasons_PenaltySystems_PenaltySystemId" FOREIGN KEY ("PenaltySystemId") REFERENCES "PenaltySystems" ("Id") ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS "Drivers" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Drivers" PRIMARY KEY AUTOINCREMENT,
    "BadgeIcons" TEXT NULL,
    "BadgeName" TEXT NULL,
    "CreatedAt" INTEGER NOT NULL,
    "Description" TEXT NULL,
    "DiscordLink" TEXT NULL,
    "DiscordName" TEXT NULL,
    "GamePlatform" INTEGER NOT NULL,
    "InGameName" TEXT NULL,
    "IsArchive" INTEGER NOT NULL,
    "LeagueCategoriesRaw" BLOB NULL,
    "LeagueRolesRaw" BLOB NULL,
    "Name" TEXT NOT NULL,
    "NationId" INTEGER NULL,
    "NationIngameId" INTEGER NULL,
    "RaceNumber" INTEGER NULL,
    "RealName" TEXT NULL,
    "SteamLink" TEXT NULL,
    "SteamName" TEXT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL, "DriverFeatures" INTEGER NULL,
    CONSTRAINT "FK_Drivers_Nationalities_NationId" FOREIGN KEY ("NationId") REFERENCES "Nationalities" ("Id") ON DELETE RESTRICT
);
CREATE INDEX "IX_Seasons_ChampionshipId" ON "Seasons" ("ChampionshipId");
CREATE INDEX "IX_Seasons_PenaltySystemId" ON "Seasons" ("PenaltySystemId");
CREATE INDEX "IX_Drivers_NationId" ON "Drivers" ("NationId");
CREATE TABLE IF NOT EXISTS "PenaltyActions" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_PenaltyActions" PRIMARY KEY AUTOINCREMENT,
    "PenaltyItemId" INTEGER NOT NULL,
    "Type" INTEGER NOT NULL,
    "Value" INTEGER NOT NULL,
    "Status" INTEGER NOT NULL,
    "TargetDriverSessionId" INTEGER NULL,
    "TargetSeasonId" INTEGER NULL,
    "ProcessedDate" TEXT NULL,
    "CreatedAt" INTEGER NOT NULL,
    "UpdatedAt" INTEGER NOT NULL,
    "UserCreated" INTEGER NOT NULL,
    "UserUpdated" INTEGER NOT NULL,
    CONSTRAINT "FK_PenaltyActions_PenaltyItems_PenaltyItemId" FOREIGN KEY ("PenaltyItemId") REFERENCES "PenaltyItems" ("Id") ON DELETE RESTRICT
);
CREATE INDEX "IX_PenaltyActions_PenaltyItemId" ON "PenaltyActions" ("PenaltyItemId");
