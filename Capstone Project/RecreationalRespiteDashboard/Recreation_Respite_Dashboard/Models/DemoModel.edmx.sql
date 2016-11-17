
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 10/03/2016 14:20:55
-- Generated from EDMX file: C:\Users\halle\Documents\NetClass\RecreationalRespiteDashboard\Recreation_Respite_Dashboard\Models\DemoModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [Recreation_Respite_Dabase_final1];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------


-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------


-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [user_name] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'user_information'
CREATE TABLE [dbo].[user_information] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [First_Name] nvarchar(max)  NOT NULL,
    [Last_Name] nvarchar(max)  NOT NULL,
    [Email] nvarchar(max)  NOT NULL,
    [phone] nvarchar(max)  NOT NULL,
    [city] nvarchar(max)  NOT NULL,
    [region] nvarchar(max)  NOT NULL,
    [UserId] int  NOT NULL
);
GO

-- Creating table 'Diagnosis'
CREATE TABLE [dbo].[Diagnosis] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Events'
CREATE TABLE [dbo].[Events] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [name] nvarchar(max)  NOT NULL,
    [location] nvarchar(max)  NOT NULL,
    [date] nvarchar(max)  NOT NULL,
    [end_date] nvarchar(max)  NOT NULL,
    [number_participant] nvarchar(max)  NOT NULL,
    [image] nvarchar(max)  NOT NULL,
    [description] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Participants'
CREATE TABLE [dbo].[Participants] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [first_name] nvarchar(max)  NOT NULL,
    [last_name] nvarchar(max)  NOT NULL,
    [gender] nvarchar(max)  NOT NULL,
    [diagnosis] nvarchar(max)  NOT NULL,
    [program_interest] nvarchar(max)  NOT NULL,
    [notes] nvarchar(max)  NOT NULL,
    [user_informationId] int  NOT NULL
);
GO

-- Creating table 'FeedBacks'
CREATE TABLE [dbo].[FeedBacks] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [description] nvarchar(max)  NOT NULL,
    [UserId] int  NOT NULL
);
GO

-- Creating table 'Articles'
CREATE TABLE [dbo].[Articles] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [name] nvarchar(max)  NOT NULL,
    [image] nvarchar(max)  NOT NULL,
    [description] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Registrations'
CREATE TABLE [dbo].[Registrations] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [first_name] nvarchar(max)  NOT NULL,
    [last_name] nvarchar(max)  NOT NULL,
    [age] nvarchar(max)  NOT NULL,
    [contact] nvarchar(max)  NOT NULL,
    [email] nvarchar(max)  NOT NULL,
    [phone] nvarchar(max)  NOT NULL,
    [program_name] nvarchar(max)  NOT NULL,
    [location] nvarchar(max)  NOT NULL,
    [program_type] nvarchar(max)  NOT NULL,
    [recreational_interest] nvarchar(max)  NOT NULL,
    [special_needs] nvarchar(max)  NOT NULL,
    [exception_goals] nvarchar(max)  NOT NULL,
    [allergies] nvarchar(max)  NOT NULL,
    [ParticipantId] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'user_information'
ALTER TABLE [dbo].[user_information]
ADD CONSTRAINT [PK_user_information]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Diagnosis'
ALTER TABLE [dbo].[Diagnosis]
ADD CONSTRAINT [PK_Diagnosis]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Events'
ALTER TABLE [dbo].[Events]
ADD CONSTRAINT [PK_Events]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Participants'
ALTER TABLE [dbo].[Participants]
ADD CONSTRAINT [PK_Participants]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'FeedBacks'
ALTER TABLE [dbo].[FeedBacks]
ADD CONSTRAINT [PK_FeedBacks]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Articles'
ALTER TABLE [dbo].[Articles]
ADD CONSTRAINT [PK_Articles]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Registrations'
ALTER TABLE [dbo].[Registrations]
ADD CONSTRAINT [PK_Registrations]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [UserId] in table 'user_information'
ALTER TABLE [dbo].[user_information]
ADD CONSTRAINT [FK_user_informationUser]
    FOREIGN KEY ([UserId])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_user_informationUser'
CREATE INDEX [IX_FK_user_informationUser]
ON [dbo].[user_information]
    ([UserId]);
GO

-- Creating foreign key on [user_informationId] in table 'Participants'
ALTER TABLE [dbo].[Participants]
ADD CONSTRAINT [FK_Participantuser_information]
    FOREIGN KEY ([user_informationId])
    REFERENCES [dbo].[user_information]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Participantuser_information'
CREATE INDEX [IX_FK_Participantuser_information]
ON [dbo].[Participants]
    ([user_informationId]);
GO

-- Creating foreign key on [UserId] in table 'FeedBacks'
ALTER TABLE [dbo].[FeedBacks]
ADD CONSTRAINT [FK_FeedBackUser]
    FOREIGN KEY ([UserId])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_FeedBackUser'
CREATE INDEX [IX_FK_FeedBackUser]
ON [dbo].[FeedBacks]
    ([UserId]);
GO

-- Creating foreign key on [ParticipantId] in table 'Registrations'
ALTER TABLE [dbo].[Registrations]
ADD CONSTRAINT [FK_RegistrationParticipant]
    FOREIGN KEY ([ParticipantId])
    REFERENCES [dbo].[Participants]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_RegistrationParticipant'
CREATE INDEX [IX_FK_RegistrationParticipant]
ON [dbo].[Registrations]
    ([ParticipantId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------