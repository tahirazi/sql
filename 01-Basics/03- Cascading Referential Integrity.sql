--It's to define actions when user attempts to delete or update a key referencing records in child tables
--Cascading Referential Integrity
ALTER TABLE [dbo].[UserProfiles]  WITH CHECK ADD  CONSTRAINT [FK_UserProfiles_Gender] FOREIGN KEY([GenderId])
REFERENCES [dbo].[Gender] ([Id])
ON UPDATE CASCADE
ON DELETE SET DEFAULT

ALTER TABLE [dbo].[UserProfiles]  WITH CHECK ADD  CONSTRAINT [FK_UserProfiles_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON UPDATE CASCADE

