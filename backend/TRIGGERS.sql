delimiter ??
CREATE TRIGGER updateTotalClanPointsOnTeamsUpdate AFTER UPDATE ON TEAMS
FOR EACH ROW
BEGIN
	declare currentClanPoints float;
	set currentClanPoints = (select c.pointsTotal from CLANS c where c.clanName = NEW.clanName);
	UPDATE CLANS SET pointsTotal = currentClanPoints + NEW.teamPoints - OLD.teamPoints where CLANS.clanName = NEW.clanName;
END;??
delimiter ;

delimiter ??
CREATE TRIGGER updateTeamPointsOnTrekInsert AFTER INSERT ON TREKLOGS
FOR EACH ROW
BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.clanName = NEW.clanName AND t.teamName = NEW.teamName);
	UPDATE TEAMS t SET teamPoints = currentTeamPoints + NEW.points where t.clanName = NEW.clanName AND t.teamName = NEW.teamName;
END;??
delimiter ;

delimiter ??
CREATE TRIGGER updateTeamPointsOnSkatingInsert AFTER INSERT ON SKATINGLOGS
FOR EACH ROW
BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.clanName = NEW.clanName AND t.teamName = NEW.teamName);
	UPDATE TEAMS t SET teamPoints = currentTeamPoints + NEW.points where t.clanName = NEW.clanName AND t.teamName = NEW.teamName;
END;??
delimiter ;

delimiter ??
CREATE TRIGGER updateTeamPointsOnKayakInsert AFTER INSERT ON KAYAKLOGS
FOR EACH ROW
BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.clanName = NEW.clanName AND t.teamName = NEW.teamName);
	UPDATE TEAMS t SET teamPoints = currentTeamPoints + NEW.points where t.clanName = NEW.clanName AND t.teamName = NEW.teamName;
END;??
delimiter ;

delimiter ??
CREATE TRIGGER updateTeamPointsOnBingoDelete AFTER DELETE ON BINGOLOGS
FOR EACH ROW
BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.clanName = OLD.clanName AND t.teamName = OLD.teamName);
	UPDATE TEAMS t SET teamPoints = currentTeamPoints - OLD.points where t.clanName = OLD.clanName AND t.teamName = OLD.teamName;
END;??
delimiter ;

delimiter ??
CREATE TRIGGER updateTeamPointsOnTrekDelete AFTER DELETE ON TREKLOGS
FOR EACH ROW
BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.clanName = OLD.clanName AND t.teamName = OLD.teamName);
	UPDATE TEAMS t SET teamPoints = currentTeamPoints - OLD.points where t.clanName = OLD.clanName AND t.teamName = OLD.teamName;
END;??
delimiter ;

delimiter ??
CREATE TRIGGER updateTeamPointsOnSkatingDelete AFTER DELETE ON SKATINGLOGS
FOR EACH ROW
BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.clanName = OLD.clanName AND t.teamName = OLD.teamName);
	UPDATE TEAMS t SET teamPoints = currentTeamPoints - OLD.points where t.clanName = OLD.clanName AND t.teamName = OLD.teamName;
END;??
delimiter ;

delimiter ??
CREATE TRIGGER updateTeamPointsOnKayakDelete AFTER DELETE ON KAYAKLOGS
FOR EACH ROW
BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.clanName = OLD.clanName AND t.teamName = OLD.teamName);
	UPDATE TEAMS t SET teamPoints = currentTeamPoints - OLD.points where t.clanName = OLD.clanName AND t.teamName = OLD.teamName;
END;??
delimiter ;

delimiter ??
CREATE TRIGGER updateTotalTeamPointsOnKayakUpdate AFTER UPDATE ON KAYAKLOGS
FOR EACH ROW
BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.teamName = NEW.teamName);
	UPDATE TEAMS SET teamPoints = currentTeamPoints + NEW.points - OLD.points where TEAMS.teamName = NEW.teamName;
END;??
delimiter ;

delimiter ??
CREATE TRIGGER updateTotalTeamPointsOnBingoUpdate AFTER UPDATE ON BINGOCARDS
FOR EACH ROW
BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.teamName = NEW.teamName);
	UPDATE TEAMS SET teamPoints = currentTeamPoints + NEW.points - OLD.points where TEAMS.teamName = NEW.teamName;
END;??
delimiter ;

delimiter ??
CREATE TRIGGER updateTeamPointsOnXseedInsert AFTER INSERT ON XSEEDLOGS
FOR EACH ROW
BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.clanName = NEW.clanName AND t.teamName = NEW.teamName);
	UPDATE TEAMS t SET teamPoints = currentTeamPoints + NEW.points where t.clanName = NEW.clanName AND t.teamName = NEW.teamName;
END;??
delimiter ;

delimiter ??
CREATE TRIGGER updateTeamPointsOnXseedDelete AFTER DELETE ON XSEEDLOGS
FOR EACH ROW
BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.clanName = OLD.clanName AND t.teamName = OLD.teamName);
	UPDATE TEAMS t SET teamPoints = currentTeamPoints - OLD.points where t.clanName = OLD.clanName AND t.teamName = OLD.teamName;
END;??
delimiter ;

delimiter ??
CREATE TRIGGER updateTotalTeamPointsOnTrekUpdate AFTER UPDATE ON TREKLOGS
FOR EACH ROW
BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.teamName = NEW.teamName);
	UPDATE TEAMS SET teamPoints = currentTeamPoints + NEW.points - OLD.points where TEAMS.teamName = NEW.teamName;
END;??
delimiter ;