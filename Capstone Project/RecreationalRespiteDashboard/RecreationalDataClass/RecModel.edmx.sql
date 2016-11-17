
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 10/02/2016 21:40:08
-- Generated from EDMX file: C:\Users\halle\Documents\NetClass\RecreationalRespiteDashboard\RecreationalDataClass\RecModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [Recreation_Respite_Dabase_final];
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
    [user_Name] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'user_information'
CREATE TABLE [dbo].[user_information] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [First_Name] nvarchar(max)  NOT NULL,
    [Last_Name] nvarchar(max)  NOT NULL,
    [email] nvarchar(max)  NOT NULL,
    [phone] nvarchar(max)  NOT NULL,
    [city] nvarchar(max)  NOT NULL,
    [region] nvarchar(max)  NOT NULL,
    [UserId] int  NOT NULL
);
GO

-- Creating table 'Participants'
CREATE TABLE [dbo].[Participants] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [First_Name] nvarchar(max)  NOT NULL,
    [Last_Name] nvarchar(max)  NOT NULL,
    [age] nvarchar(max)  NOT NULL,
    [gender] nvarchar(max)  NOT NULL,
    [diagnosis] nvarchar(max)  NOT NULL,
    [program_interest] nvarchar(max)  NOT NULL,
    [notes] nvarchar(max)  NOT NULL,
    [user_informationId] int  NOT NULL
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
    [Name] nvarchar(max)  NOT NULL,
    [location] nvarchar(max)  NOT NULL,
    [date] nvarchar(max)  NOT NULL,
    [Number_Participant] nvarchar(max)  NOT NULL,
    [image] nvarchar(max)  NOT NULL,
    [description] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Feedbacks'
CREATE TABLE [dbo].[Feedbacks] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [description] nvarchar(max)  NOT NULL,
    [UserId] int  NOT NULL
);
GO

-- Creating table 'Articles'
CREATE TABLE [dbo].[Articles] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [image] nvarchar(max)  NOT NULL,
    [description] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Registrations'
CREATE TABLE [dbo].[Registrations] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [First_Name] nvarchar(max)  NOT NULL,
    [Last_Name] nvarchar(max)  NOT NULL,
    [age] nvarchar(max)  NOT NULL,
    [contact] nvarchar(max)  NOT NULL,
    [phone] nvarchar(max)  NOT NULL,
    [email] nvarchar(max)  NOT NULL,
    [program_name] nvarchar(max)  NOT NULL,
    [location] nvarchar(max)  NOT NULL,
    [payment_type] nvarchar(max)  NOT NULL,
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

-- Creating primary key on [Id] in table 'Participants'
ALTER TABLE [dbo].[Participants]
ADD CONSTRAINT [PK_Participants]
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

-- Creating primary key on [Id] in table 'Feedbacks'
ALTER TABLE [dbo].[Feedbacks]
ADD CONSTRAINT [PK_Feedbacks]
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
ADD CONSTRAINT [FK_Useruser_information]
    FOREIGN KEY ([UserId])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Useruser_information'
CREATE INDEX [IX_FK_Useruser_information]
ON [dbo].[user_information]
    ([UserId]);
GO

-- Creating foreign key on [user_informationId] in table 'Participants'
ALTER TABLE [dbo].[Participants]
ADD CONSTRAINT [FK_user_informationParticipant]
    FOREIGN KEY ([user_informationId])
    REFERENCES [dbo].[user_information]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_user_informationParticipant'
CREATE INDEX [IX_FK_user_informationParticipant]
ON [dbo].[Participants]
    ([user_informationId]);
GO

-- Creating foreign key on [UserId] in table 'Feedbacks'
ALTER TABLE [dbo].[Feedbacks]
ADD CONSTRAINT [FK_FeedbackUser]
    FOREIGN KEY ([UserId])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_FeedbackUser'
CREATE INDEX [IX_FK_FeedbackUser]
ON [dbo].[Feedbacks]
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