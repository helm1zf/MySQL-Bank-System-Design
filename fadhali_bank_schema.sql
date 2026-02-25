DROP 	DATABASE IF 	EXISTS fadhali_bank;
SET FOREIGN_KEY_CHECKS=0;
SET GLOBAL FOREIGN_KEY_CHECKS=0;

CREATE 	DATABASE IF NOT EXISTS fadhali_bank;
USE fadhali_bank;

#---------------------------------------------------------------------------------------------------- TABEL ERSTELLEN # ----------------------------------------------------------------------------------------------------
DROP 	TABLE 	IF 		EXISTS Customer;
CREATE 	TABLE Customer ( 
		ID 								INTEGER 	(4)	 	UNIQUE 		NOT NULL 	AUTO_INCREMENT,
		Vorname 						VARCHAR		(20) 				NOT NULL,
		Nachname 						VARCHAR		(20) 				NOT NULL,
        Geburtsdatum 					DATE 							NOT NULL,
        Beruf 							VARCHAR 	(20) 				NOT NULL,
        Adresse							VARCHAR 	(50) 				NOT NULL,
        PLZ 							INTEGER		(5) 				NOT NULL,
        Ort 							VARCHAR		(20) 				NOT NULL,
				
		CONSTRAINT 	PK_1	PRIMARY KEY (ID)
        
        
	);
ALTER	TABLE Customer AUTO_INCREMENT=1001;

DROP 	TABLE 	IF 		EXISTS Filliale;
CREATE 	TABLE Filliale ( 
		FilNr 							INTEGER 	(7) UNIQUE 	NOT NULL 		AUTO_INCREMENT,
		FilName 						VARCHAR	    (20) 						DEFAULT 'FADHALI BANK AG',
        FilStadt 						VARCHAR     (20)		NOT NULL,
        
        CONSTRAINT PK_1 PRIMARY KEY (FilNr)
        
        
	);
ALTER	TABLE Filliale auto_increment=9002001;

DROP 	TABLE 	IF 		EXISTS Bankkonto;
CREATE 	TABLE Bankkonto	(	
		KontoNr 						INTEGER 	(6 )	UNIQUE 		NOT NULL 	AUTO_INCREMENT,
		Kontotype 						VARCHAR		(30) 	check 		(Kontotype in ('Saving','Checking','Certificate of Deposit','Money Market','Individual Retirement','Giro')),
        datumeroeffnung 				DATE,
        Kontostatus 					VARCHAR		(30) 	check 		(Kontostatus in ('Active','Inactive','Suspended','Terminated')),
        
        CONSTRAINT PK_1	PRIMARY KEY (KontoNr)
        
        
    );
ALTER 	TABLE Bankkonto auto_increment=666661;
# Active 		- Bankkonto wurde in den letzten 12 Monat mindestens einmal für Transaktionen verwendet.
# Inactive 		- Bankkonto wurde in den letztzen 12 Monat keine Transaktionen verwerndet.
# Suspended 	- Bankkonto wurde ungewöhnliche Kontoaktivitäten aufgefallen.
# Terminated 	- Negative Guthaben	/ Betrug verdächtigt	/	Bank-/Kontorichtlinie brechen.


DROP 	TABLE 	IF 		EXISTS unbekannte_bank;
CREATE TABLE unbekannte_bank (
		KontoNr			INTEGER(6 ),
        Inhaber			VARCHAR(50),
        Bankname		VARCHAR(20),
		BICCODE			VARCHAR(11),
        
        CONSTRAINT PK_1 PRIMARY KEY (KontoNr)
		);

DROP 	TABLE 	IF 		EXISTS Kredit;
CREATE 	TABLE Kredit (
		KreditNr 						INTEGER (3) 	NOT NULL 		auto_increment,
        Kreditbetrag 					INTEGER			NOT NULL,
        
        CONSTRAINT PK_1 PRIMARY KEY						(KreditNr)
	);
ALTER 	TABLE Kredit auto_increment=111;

DROP 	TABLE 	IF 		EXISTS Mitarbeiter;
CREATE TABLE Mitarbeiter (
		ID								INTEGER 		UNIQUE 		NOT NULL 		auto_increment,
		Vorname 						VARCHAR			(20),
		Nachname 						VARCHAR 		(20)
	);
ALTER TABLE Mitarbeiter auto_increment=10000001;


DROP 	TABLE 	IF 		EXISTS haben;
CREATE 	TABLE  haben (
		CustomerID 						INTEGER,
        KontoNr							INTEGER,
        CONSTRAINT FK_1 FOREIGN KEY (CustomerID) 		REFERENCES Customer(ID),
        CONSTRAINT FK_2 FOREIGN KEY (KontoNr) 			REFERENCES Bankkonto(KontoNr)
	);

DROP 	TABLE 	IF 		EXISTS erstellt_in;
CREATE 	TABLE erstellt_in(
		KontoNr 						INTEGER,
        FilNr 							INTEGER,
        CONSTRAINT FK_3 FOREIGN KEY	(KontoNr)			REFERENCES Bankkonto(KontoNr),
        CONSTRAINT FK_4 FOREIGN KEY	(FilNr)				REFERENCES Filliale(FilNr)
        );
        
DROP 	TABLE 	IF 		EXISTS ueberweisen;
CREATE 	TABLE ueberweisen (
		KontoNr_absender 				INTEGER 	NOT NULL,
		denBetrag 						INTEGER 	NOT NULL,
        verwendungszweck 				VARCHAR		(50),
        KontoNr_empfaenger 				INTEGER 	NOT NULL,
		datum 							DATE,
        mitteilung						VARCHAR		(20),
        
		CONSTRAINT FK_5 FOREIGN KEY (KontoNr_absender) 		REFERENCES Bankkonto(KontoNr),
		CONSTRAINT FK_6 FOREIGN KEY (KontoNr_absender)		REFERENCES unbekannte_bank(KontoNr),
		CONSTRAINT FK_7 FOREIGN KEY (KontoNr_empfaenger)	REFERENCES Bankkonto(KontoNr),
        CONSTRAINT FK_8 FOREIGN KEY (KontoNr_empfaenger)	REFERENCES unbekannte_bank(KontoNr)
	);

DROP 	TABLE 	IF 		EXISTS aufnehmen;
CREATE 	TABLE aufnehmen (
		KontoNr 						INTEGER,
        KreditNr						INTEGER,
        CONSTRAINT FK_9 FOREIGN KEY 					(KreditNr) 		REFERENCES Kredit(KreditNr) 	ON DELETE CASCADE,
        CONSTRAINT FK_10 FOREIGN KEY 					(KontoNr)		REFERENCES Bankkonto(KontoNr) 	ON DELETE CASCADE
    );

DROP 	TABLE	IF 	EXISTS bedienen;
CREATE 	TABLE 	bedienen ( 
		MitarbeiterID 					INTEGER,
		CustomerID 						INTEGER,
		datum 							DATE,
		bewertung 						VARCHAR(20),
		CONSTRAINT FK_11 FOREIGN KEY 					(MitarbeiterID) REFERENCES Mitarbeiter(ID),
		CONSTRAINT FK_12 FOREIGN KEY 					(CustomerID) 	REFERENCES Customer(ID)
);


DROP TABLE IF EXISTS arbeiten_in;
CREATE TABLE arbeiten_in (
		MitarbeiterID INTEGER,
        FilNr		  INTEGER,
        CONSTRAINT FK_13 FOREIGN KEY 					(MitarbeiterID) REFERENCES Mitarbeiter(ID) ON DELETE CASCADE,
        CONSTRAINT FK_14 FOREIGN KEY					(FilNr)			REFERENCES Filliale(FilNr) ON DELETE CASCADE
        );
#---------------------------------------------------------------------------------------------------- RECORDS ERSTELLEN # ----------------------------------------------------------------------------------------------------
INSERT INTO CUSTOMER (Vorname			,Nachname			,Geburtsdatum		,Beruf					,Adresse					,PLZ		,Ort) VALUES 
					('Upin'				,'Nax Pamulang'		, DATE '1990-01-20'	,'Naturwissenschaftler'	,'Karl-Marxstaße 10'		,'54292'	,'Trier'		),
					('Jarjit'			,'Kaufmann'			, DATE '1999-09-05'	,'Angestellte'			,'Behringstraße 2'			,'52135'	,'Wittlich'		),
					('Freddy'			,'Zaky'				, DATE '1995-01-11'	,'Lehrer'				,'Alfons-Leitl-Straße'		,'54290'	,'Trier'		),
					('Zaza'				,'de Gagak'			, DATE '2002-04-29'	,'Studentin'			,'Bedastraße'				,'54634'	,'Bitburg'		),
					('Angga'			,'Si Sopan'			, DATE '2003-08-24'	,'Schuler'				,'Neuerburgerstraße 2'		,'54922'	,'Wittlich'		),
					('Satria'			,'La Cengir'		, DATE '2000-07-11'	,'Student'				,'Heilenbacherstraße 2'		,'54636'	,'Ehlenz'		),
					('Amel'				,'Ngomelia'			, DATE '1995-12-05'	,'Anwältin'				,'Goethestraße'				,'52135'	,'Bonn'			),
					('Antje Luft'		,'Hartmann'			, DATE '2002-03-19'	,'Microeconomist'		,'Leopaoldstraße'			,'52634'	,'Bitburg'		),
					('Felix Gottlieb'	,'Zimmermann'		, DATE '2002-08-18'	,'Designer'				,'Sonnealle 16'				,'52135'	,'Wittlich'		),
					('Robert'			,'Hubbard'			, DATE '1973-11-09'	,'Dozent'				,'Neuernbergerstraße 29'	,'52132'	,'Bonn'			),
					('Indro'			,'Sidoarjo'			, DATE '1965-09-11'	,'Arsitektur'			,'Hauptstraße'				,'54636'	,'Ehlenz'		),
					('Sven'				,'Osterhagen'		, DATE '1996-05-24'	,'Umwelttechniker'		,'Gartenstraße'				,'54290'	,'Trier'		),
					('Sophie'			,'Schweitzer'		, DATE '1965-03-15'	,'Fahrerin'				,'Wiesenwegstraße'			,'54294'	,'Trier'		),
					('Brigita'			,'Pricilla Guntur'	, DATE '1992-12-08'	,'Zähnärztin'			,'Jahnstraße'				,'52134'	,'Bonn'			),
					('Widi'				,'Plammann'			, DATE '1988-11-28'	,'Handwerker'			,'Goethestraße 15'			,'52130'	,'Wittlich'		),    
					('Alexander'		,'Bells'			, DATE '1998-06-23'	,'Informatiker'			,'Bahnhofstraße 12'			,'54920'	,'Wittlich'		),
					('Antonio'			,'Bates'			, DATE '1981-05-22'	,'Ärzte'				,'Friedhofstraße'			,'26389'	,'Wilhelmshaven'),
					('Catherine'		,'Fishermann'		, DATE '1969-11-11'	,'Energieberater'		,'Friedrich-Wolf Straße'	,'52634'	,'Bitburg'		),
					('Felix'			,'Peter'			, DATE '1999-01-29'	,'Fahrer'				,'Limbourgs Hof'			,'23966'	,'Wismar'		);


INSERT INTO Filliale	(FilStadt) VALUES 
						('Wismar'),
						('Trier'),
						('Trier'),
						('Wittlich'),
						('Wittlich'),
						('Bitburg'),
						('Bonn'),
						('Ehlenz'),
						('Wismar');


INSERT INTO Bankkonto 	(Kontotype					,datumeroeffnung	,Kontostatus		) VALUES
						('Checking'					,DATE '2020-10-10'	,'Active'			),									
						('Saving'					,DATE '2021-07-12'	,'Active'			),														
						('Money Market'				,DATE '2021-04-29'	,'Suspended'		),                                                      
						('Certificate of Deposit'	,DATE '2020-02-02'	,'Terminated'		),                                                      
						('Checking'					,DATE '2021-08-10'	,'Suspended'		),                                                      
						('Saving'					,DATE '2018-09-05'	,'Inactive'			),                                                      
						('Saving'					,DATE '2020-04-23'	,'Active'			),                                                      
						('Checking'					,DATE '2019-07-29'	,'Active'			),                                                      
						('Saving'					,DATE '2012-06-16'	,'Active'			),                                                      
						('Money Market'				,DATE '2012-06-16'	,'Active'			),                                                      
						('Giro'						,DATE '2017-09-21'	,'Active'			),                                                      
						('Saving'					,DATE '2022-08-11'	,'Active'			),                                                      
						('Giro'						,DATE '2018-09-11'	,'Active'			),                                                      
						('Money Market'				,DATE '2015-02-23'	,'Inactive'			),                                                      
						('Saving'					,DATE '2021-11-16'	,'Active'			),                                                      
						('Checking'					,DATE '2019-06-29'	,'Active'			);    
                        
INSERT INTO unbekannte_bank	(KontoNr	,Inhaber		,Bankname				,BICCODE	  ) VALUES
							(621356		,'Unternehmen A','COMMERZBANK AG'		,'COMMDEEEXXX'),
                            (623566		,'Unternehmen B','SPARKASSE AG' 		,'SPARKASSXXX'),
                            (625213		,'Unternehmen C','DEUTSCHE BANK AG' 	,'DEBAAGEEXXX'),
                            (625352		,'Unternehmen D','SPARKASSE	AG' 		,'SPARKASSXXX'),
                            (626547		,'Unternehmen E','DEUTSCHE BANK AG' 	,'COMMDEEEXXX'),
							(612363		,'Hotel B&B','COMMERZBANK AG'			,'COMMDEEEXXX'),
                            (612366		,'Unternehmen G','SPARKASSE AG' 		,'SPARKASSXXX'),
                            (617764		,'SOS Kinderdorf','DEUTSCHE BANK AG' 	,'DEBAAGEEXXX'),
                            (621362		,'Unternehmen J','DEUTSCHE BANK AG' 	,'COMMDEEEXXX'),
                            (623156		,'Unternehmen K','COMMERZBANK AG'		,'COMMDEEEXXX'),
                            (623166		,'Kebab Restaurant','SPARKASSE AG' 		,'SPARKASSXXX'),
                            (661246		,'Unternehmen M','DEUTSCHE BANK AG' 	,'DEBAAGEEXXX'),
                            (661621		,'MediaMarkt GmbH','SPARKASSE AG' 		,'SPARKASSXXX'),
                            (666123		,'Unternehmen O','DEUTSCHE BANK AG' 	,'COMMDEEEXXX'),
                            (666126		,'Autowerkstatt TOTALRUND','DEUTSCHE BANK AG' 	,'COMMDEEEXXX'),
                            (999999		,'Rundfunkanstalten','DEUTSCHE BANK AG' 	,'COMMDEEEXXX');
                                                                                                                  
INSERT INTO haben	(CustomerID	,KontoNr	) VALUES                                                              
					(1001		,666661		),                                                                    
                    (1002		,666662		),                                                                    
                    (1003		,666663		),                                                                    
                    (1004		,666664		),                                                                    
                    (1005		,666665		),                                                                    
                    (1006		,666666		),
                    (1007		,666667		),
                    (1008		,666668		),
                    (1009		,666669		),
                    (1010		,666670		),
                    (1011		,666671		),
                    (1012		,666672		),
                    (1013		,666673		),
                    (1014		,666674		),
                    (1015		,666675		),
					(1017		,666676		);

INSERT INTO erstellt_in	( KontoNr			,FilNr	) VALUES 
						(666661				,9002002	),
                        (666662		        ,9002004    ),
                        (666663		        ,9002003    ),
                        (666664		        ,9002001    ),
                        (666665		        ,9002006    ),
                        (666666		        ,9002004    ),
                        (666667		        ,9002008    ),
                        (666668		        ,9002007    ),
                        (666669		        ,9002006    ),
                        (666670		        ,9002007    ),
                        (666671		        ,9002008    ),
                        (666672		        ,9002004    ),
                        (666673		        ,9002003    ),
                        (666674		        ,9002006    ),
                        (666675		        ,9002002    ),
                        (666676		        ,9002011    );



INSERT INTO ueberweisen	(KontoNr_absender	,denBetrag	,verwendungszweck		,KontoNr_empfaenger		,	datum		, mitteilung) VALUES 
						(666662 			,250		,'Wohnmiete'			,621362					,DATE '2022-12-01'	,'erfolgt'	),		
						(666661				,500		,'Wohnmiete'			,623156					,DATE '2020-12-01'	,'erfolgt'	),
						(625352 			,1500		,'Gehalt'				,666123					,DATE '2020-12-05'	,'erfolgt'	),
						(623566			 	,2000		,'Gehalt'				,666673					,DATE '2020-12-01'	,'erfolgt'	),
						(666661 			,750		,'neues iPhone'			,661621					,DATE '2022-12-12'	,'erfolgt'	),
						(666670 			,200000		,'neues Haus'			,661246					,DATE '2022-01-06'	,'erfolgt'	),
						(625213 			,60000		,'Gehalt'				,666661					,DATE '2020-10-01'	,'erfolgt'	),
                        (625352 			,130000		,'Gehalt als Arsitektur',666671					,DATE '2022-10-01'	,'erfolgt'	),
						(666669 			,299		,'Reparatur des Auto'	,666126					,DATE '2022-01-05'	,'erfolgt'	),
						(666674 			,315		,'Hotel Reservierung'	,612363					,DATE '2020-08-10'	,'erfolgt'	),
						(666675 			,200		,'Neu Kopfhörer'		,661621					,DATE '2021-01-10'	,'erfolgt'	),
						(666673 			,116.75		,'Einkauf'				,612366					,DATE '2022-12-12'	,'erfolgt'	),
						(666667 			,245		,'Wohnmiete'			,621356					,DATE '2021-05-10'	,'erfolgt'	),
						(666661 			,500		,'Spende'				,617764					,DATE '2020-01-22'	,'erfolgt'	),
						(626547 			,850		,'Gehalt'				,666667					,DATE '2022-09-29'	,'erfolgt'	),
						(621356 			,900		,'Gehalt'				,666668					,DATE '2022-06-12'	,'erfolgt'	),
						(666661		 		,18.5		,'monatlich ARD'		,999999					,DATE '2022-08-12'	,'erfolgt'	),
						(666662 			,18.5		,'monatlich ARD'		,999999					,DATE '2022-04-27'	,'erfolgt'	),
						(666666 			,18.5		,'monatlich ARD'		,999999					,DATE '2020-01-11'	,'erfolgt'	),
						(666671 			,18.5		,'monatlich ARD'		,999999					,DATE '2022-01-23'	,'erfolgt'	),
						(666672 			,18.5		,'monatlich ARD'		,999999					,DATE '2022-07-16'	,'erfolgt'	),
						(666671 			,600		,'Kauf neues E-Fahrrad'	,661621					,DATE '2022-09-19'	,'erfolgt'	),
						(666661 			,5			,'Döner Box'			,623166					,DATE '2022-04-21'	,'abgelehnt');

		
INSERT INTO Kredit	(Kreditbetrag) VALUES 
					(55000		),
					(30000		),
					(55000		),
					(75000		),
					(50000		),
					(25000		),
					(7500		),
					(25000		),
					(10000		),
					(5000		),
					(200000		),
					(20000		),
					(1000		);

INSERT INTO aufnehmen 	(KontoNr	,KreditNr) VALUES 
						(666669		,112	), 
						(666666		,115	), 
						(666671		,116	), 
						(666661		,114	), 
						(666668		,117	), 
						(666672		,113	), 
						(666676		,111	), 
						(666665		,122	), 
						(666671		,119	), 
						(666661		,120	), 
						(666662		,121	), 
						(666661		,118	), 
						(666664		,123	); 

INSERT INTO Mitarbeiter		(Vorname		,Nachname		) VALUES
							('Elli'			,'Breitenbach'	),
							('Sigrid'		,'Recker'		),
							('Ulrike '		,'Buss'			),
							('Hella'		,'Schneider'	),
							('Dachs'		,'Hofmann'		),
							('Rolf'			,'Tiedemann'	),
							('Margareta'	,'Lang'			),
							('Benedikt '	,'Stute'		),
							('Wilhelmine '	,'Sauber'		),
							('Rebekka '		,'Vieth'		),
                            ('Meta'			,'Keller'		),
							('Christoph'	,'Richter'		),
							('Emmerich '	,'Bauer'		),
							('Lutz'			,'Tiedemann'	),
							('Viktoria'		,'Sander'		),
							('Amalia'		,'Plank'		),
							('Aldrich'		,'Weiss'		),
							('Wanda'		,'Hofmann'		),
							('Frieda '		,'Heinrich'		),
							('Rosemarie '	,'Ritter'		),
                            ('Zelda'		,'Baumann'		),
							('Markus'		,'Braun'		),
							('Adolf '		,'Schulz'		),
							('Amala'		,'Bergmann'		),
							('Valentina'	,'Bauer'		),
							('Herge'		,'Kallenbach'	),
							('Naveen'		,'Nottebohm'	),
							('Mohammed '	,'Salah'		),
							('Johannes '	,'Sauber'		),
							('Adam '		,'Stoltenberg'	),
                            ('Jonathan'		,'Nesselrode'	),
                            ('Samira'		,'Aigner'		),
							('Aayden '		,'Ehmann'		),
							('Tyron'		,'Solomon'		),
							('Markus'		,'Katz'			),
							('Caterina'		,'Baak'			),
							('Csenge'		,'Ainsworth'	),
							('Ranjit '		,'Arud'			),
							('Brigitta '	,'Devi'			),
							('Timotheos '	,'Glass'		),
                            ('Gustava'		,'Joiner'		),
							('Richard'		,'O´Neal'		),
							('Alpin '		,'Massey'		),
							('Sultan'		,'Gerst'		),
							('Krab'			,'nax Bandung'	),
							('Spongebob'	,'Squarepants'	),
							('Jokowi'		,'Lang'			),
							('Donald '		,'Duck'			),
							('Trump '		,'Sitompul'		),
							('Laurentia '	,'Berti '		);
                            
                            
                            
INSERT INTO arbeiten_in		(MitarbeiterID	,FilNr			) VALUES
							(10000001		,9002001		),
							(10000002		,9002008		),
                            (10000003		,9002004		),
                            (10000004		,9002005		),
                            (10000005		,9002002		),
                            (10000006		,9002004		),
                            (10000007		,9002006		),
                            (10000008		,9002007		),
                            (10000009		,9002005		),
                            (10000010		,9002008		),
                            (10000011		,9002004		),
							(10000012		,9002007		),
                            (10000013		,9002006		),
                            (10000014		,9002006		),
                            (10000015		,9002001		),
                            (10000016		,9002008		),
                            (10000017		,9002004		),
                            (10000018		,9002008		),
                            (10000019		,9002005		),
                            (10000020		,9002006		),
                            (10000021		,9002003		),
							(10000022		,9002008		),
                            (10000023		,9002002		),
                            (10000024		,9002009		),
                            (10000025		,9002005		),
                            (10000026		,9002002		),
                            (10000027		,9002006		),
                            (10000028		,9002004		),
                            (10000029		,9002009		),
                            (10000030		,9002002		),
                            (10000031		,9002005		),
							(10000032		,9002003		),
                            (10000033		,9002007		),
                            (10000034		,9002001		),
                            (10000035		,9002009		),
                            (10000036		,9002002		),
                            (10000037		,9002009		),
                            (10000038		,9002009		),
                            (10000039		,9002007		),
                            (10000040		,9002006		),
                            (10000041		,9002001		),
                            (10000042		,9002003		),
                            (10000043		,9002002		),
                            (10000044		,9002007		),
                            (10000045		,9002009		),
                            (10000046		,9002003		),
                            (10000047		,9002001		),
                            (10000048		,9002003		),
                            (10000049		,9002003		),
                            (10000050		,9002003		);
                            
                           
                            
																	
                            

INSERT INTO bedienen		(MitarbeiterID	,CustomerID	,datum,	bewertung) VALUES
							(10000001		,1019		,DATE '2020-07-02','Gut'),
							(10000001		,1019		,DATE '2022-12-01','Gut'),
							(10000034		,1019		,DATE '2022-12-05','ungenügend'),
							(10000045		,1019		,DATE '2022-01-05','ungenügend'),
							(10000038		,1019		,DATE '2022-08-10','Gut'),
							(10000029		,1019		,DATE '2022-01-10','Gut'),
							(10000035		,1019		,DATE '2022-12-12','Sehr gut'),
                            (10000015		,1019		,DATE '2022-12-12','Sehr gut'),
                            (10000024		,1019		,DATE '2022-11-02','ungenügend'),
                            (10000024		,1019		,DATE '2022-12-05','ungenügend'),
                            (10000037		,1019		,DATE '2022-12-05','ungenügend'),
                            (10000041		,1019		,DATE '2022-04-27','Gut'),
                            (10000047		,1019		,DATE '2022-02-11','Gut'),
                            
                            (10000049		,1013		,DATE '2022-01-11','Gut'),
							(10000036		,1003		,DATE '2022-09-29','Gut'),
							(10000030		,1001		,DATE '2022-06-12','Gut'),
							(10000005		,1003		,DATE '2022-08-12','Gut'),
							(10000023		,1012		,DATE '2022-04-27','Gut'),
							(10000043		,1012		,DATE '2022-01-11','Gut'),
							(10000026		,1001		,DATE '2022-12-23','ungenügend'),
							(10000046		,1012		,DATE '2022-07-16','Gut'),
							(10000048		,1013		,DATE '2022-12-19','Gut'),
							(10000021		,1001		,DATE '2022-12-23','Gut'),
							(10000032		,1001		,DATE '2022-04-21','Sehr gut'),
                            (10000042		,1012		,DATE '2022-01-11','Gut'),
							(10000043		,1012		,DATE '2022-03-11','Gut'),
                            (10000050		,1001		,DATE '2022-01-11','Gut'),

							(10000003		,1002		,DATE '2022-09-29','Gut'),
							(10000006		,1005		,DATE '2022-06-12','Gut'),
							(10000011		,1009		,DATE '2022-08-12','Gut'),
							(10000017		,1002		,DATE '2022-04-27','Gut'),
							(10000028		,1009		,DATE '2022-01-11','Gut'),
							(10000009		,1016		,DATE '2022-12-23','ungenügend'),
							(10000004		,1002		,DATE '2022-07-16','Gut'),
							(10000019		,1015		,DATE '2022-12-19','Gut'),
							(10000031		,1005		,DATE '2022-12-21','Sehr gut'),
							(10000025		,1002		,DATE '2022-12-23','Gut'),
                            
                            
                            
							(10000007		,1004		,DATE '2022-07-16','Gut'),
							(10000014		,1008		,DATE '2022-09-19','Sehr gut'),
							(10000020		,1018		,DATE '2022-04-21','Sehr gut'),
							(10000027		,1018		,DATE '2022-09-29','Gut'),
							(10000013		,1008		,DATE '2022-06-12','Gut'),
							(10000040		,1004		,DATE '2022-08-12','Gut'),
                            
                            
							(10000012		,1007		,DATE '2022-04-27','Gut'),
							(10000008		,1010		,DATE '2022-01-11','Gut'),
							(10000044		,1014		,DATE '2022-12-23','ungenügend'),
							(10000033		,1007		,DATE '2022-07-16','Gut'),
                            (10000039		,1007		,DATE '2022-04-27','Gut'),
                            
							(10000010		,1006		,DATE '2022-10-23','Gut'),
                            (10000002		,1011		,DATE '2022-04-23','Gut'),
                            (10000016		,1006		,DATE '2022-02-11','Gut'),
                            (10000018		,1011		,DATE '2022-12-28','Gut'),
                            (10000022		,1006		,DATE '2022-10-21','Gut');
                            

SELECT * FROM customer
			order by Ort;
SELECT * FROM Filliale;
SELECT * FROM arbeiten_in
		order by FilNr asc;
SELECT * FROM haben;
SELECT * FROM Bankkonto;
SELECT * FROM unbekannte_bank;
SELECT * FROM ueberweisen
		order by KontoNr_Absender asc;

SELECT * FROM erstellt_in;
SELECT * FROM Kredit;
SELECT * FROM aufnehmen
		order by KontoNr asc;
SELECT * FROM mitarbeiter
		order by ID asc;
SELECT * FROM bedienen
		order by MitarbeiterID;
SELECT * FROM unbekannte_bank;



