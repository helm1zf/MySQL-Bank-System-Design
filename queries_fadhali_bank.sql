USE fadhali_bank;


# 	1. Geben Sie bitte die gesamten Ausgaben jedes Konto aus. Sortieren Sie aufsteigend nach gesamten Ausgaben
	( 	# DIE ANTWORT # )
    SELECT 	Customer.ID,
			ueberweisen.KontoNr_Absender,
            Customer.Vorname,
            Customer.Nachname,
            unbekannte_bank.Inhaber,
            sum(denBetrag) as Total_Ausgaben
	FROM ueberweisen
	LEFT JOIN haben  on haben.KontoNr= ueberweisen.KontoNr_Absender
    LEFT JOIN Customer on Customer.ID = haben.CustomerID
    LEFT JOIN unbekannte_bank on unbekannte_bank.KontoNr = ueberweisen.KontoNr_Absender
			group by KontoNr_Absender
            order by sum(denBetrag) desc
	);

#  	2. Geben Sie bitte die gesamten Einnehmen jedes Konto aus
	( 	# DIE ANTWORT # )
    SELECT 	Customer.ID,
			ueberweisen.KontoNr_empfaenger,
			Customer.Vorname,
			Customer.Nachname,
            unbekannte_bank.Inhaber,
			sum(denBetrag) as Total_Einnahmen
	FROM ueberweisen
	
			LEFT JOIN haben  on haben.KontoNr= ueberweisen.KontoNr_empfaenger
			LEFT JOIN Customer on Customer.ID = haben.CustomerID
			LEFT JOIN unbekannte_bank on unbekannte_bank.KontoNr = ueberweisen.KontoNr_empfaenger
			group by KontoNr_empfaenger
            order by sum(denBetrag) desc
		
	);

#  	3. 	Welche Kunden hat kein Bankkonto?
( 	# DIE ANTWORT # )
	SELECT 	Customer.ID,
			Customer.Vorname,
			Customer.Nachname,
            Customer.Adresse,
            Customer.PLZ,
            Customer.Ort
	FROM Customer
	WHERE NOT EXISTS ( SELECT * FROM haben where haben.CustomerID=Customer.ID) 
);

# 	4.	Welche Kunden hat Bankkonto aber hat kein Filliale in ihren Stadt
(	# DIE ANTWORT # )
	SELECT 	Bankkonto.KontoNr,
			Customer.Vorname,
			Customer.Nachname,
            Customer.Adresse,
            Customer.PLZ,
            Customer.Ort
	FROM Bankkonto
    
LEFT JOIN haben ON haben.KontoNr= Bankkonto.KontoNr
LEFT JOIN Customer ON haben.CustomerID= Customer.ID
WHERE NOT EXISTS ( SELECT * FROM Filliale where Filliale.FilStadt=Ort)

);


#	5.	Wie viel Kunden hat Mitarbeiter Kunden bedient?
	(	# DIE ANTWORT #	)
		SELECT 	Mitarbeiter.ID,
				Mitarbeiter.Vorname,
                Mitarbeiter.Nachname,
                count(MitarbeiterID) as Total_Kunden
		from Mitarbeiter
        left join bedienen on Mitarbeiter.ID=bedienen.MitarbeiterID
        group by Mitarbeiter.ID
        order by Mitarbeiter.ID asc
				
);
	
# 	6. 	Welche Kunden hat ab 2020 einen Konto eröffnet?
	(	# DIE ANTWORT #	)
		SELECT	Customer.ID, 	
				Bankkonto.KontoNr,
				Customer.Vorname,
				Customer.Nachname,
                Bankkonto.Kontotype,
                Bankkonto.datumeroeffnung,
                Bankkonto.Kontostatus
        FROM Bankkonto 
        LEFT JOIN haben on haben.KontoNr=Bankkonto.KontoNr
        LEFT JOIN Customer on Customer.ID=haben.CustomerID
        WHERE datumeroeffnung > '2020-01-01 11:00:00'
    );
     
#	7. 	Welche Mitarbeiter hat Kunde, der Upin Nax Pamulang heißt, bedient?
	(	# DIE ANTWORT #	)
		SELECT 	bedienen.MitarbeiterID,
				Mitarbeiter.Vorname,
                Mitarbeiter.Nachname,
                bedienen.datum
        from bedienen
        left join Mitarbeiter on bedienen.MitarbeiterID=Mitarbeiter.ID
        where exists (SELECT * FROM CUSTOMER where bedienen.CustomerID = customer.ID and customer.Vorname='Upin' and customer.Nachname='Nax Pamulang')
    ); 

#	8. 	Welche Mitarbeiter  hat 'ungenügend' Bewertung bekommen, wie öft hat sie die Bewertung 'ungenügend' bekommen? Sortieren Sie aufsteigend nach MitarbeiterID
	( 	# DIE ANTWORT #	)
		SELECT	bedienen.MitarbeiterID,
				Mitarbeiter.Vorname,
                Mitarbeiter.Nachname,
                count(bewertung) as Total_Fällen
		from bedienen
        left join Mitarbeiter on bedienen.MitarbeiterID=Mitarbeiter.ID
        where bedienen.bewertung='ungenügend'
        
        order by MitarbeiterID);
                
# 	9. Wie viel Mitarbeiter hat je Filliale


(SELECT	
		arbeiten_in.FilNr,
		count(arbeiten_in.MitarbeiterID) as Total_Mitarbeiter
        from arbeiten_in
        group by FilNr
);


                            
                            
                            
                            
                            
                            
                            
                            
                            
#	10.	