Option Explicit

'Date Functions Library
'This library contains various VBScript functions for often-used date handling needs
'Copyright 2002 Roman Koch (http://www.romankoch.ch)

'Update 10. April 2005
'df_Monthname, df_Weekdayname: Parameter changed to ISO 639 two-letter codes, support for Spanish

Dim sTest 'string to hold the test results

Function df_Easter (ByVal iYear)
	'returns the Easter date for a given year
	'or 0 if the year is invalid
	Dim iMonth, iDay, iMoon, iEpact, iSunDay, iGold, iCent, iCorx, iCorz
	If IsNumeric (iYear) Then
	    iYear = CInt(iYear)
	    If (iYear >= 1583) And (iYear <= 8702) Then
        	iGold = ((iYear Mod 19) + 1) 'the golden number of the year in the 19 year metonic cycle
         	iCent = ((Int(iYear / 100)) + 1) 'calculate the century
        	iCorx = (Int((3 * iCent) / 4) - 12) 'no. of years in which leap year was dropped in order to keep in step with the sun
        	iCorz = (Int((8 * iCent + 5) / 25) - 5) 'special correction to syncronize easter with the moon's orbit
        	iSunDay = (Int((5 * iYear) / 4) - iCorx - 10) 'find sunday
        	iEpact = ((11 * iGold + 20 + iCorz - iCorx) Mod 30) 'set epact (specifies occurance of full moon
        	If (iEpact < 0) Then iEpact = iEpact + 30
        	If ((iEpact = 25) And (iGold > 11)) Or (iEpact = 24) Then iEpact = iEpact + 1
        	iMoon = 44 - iEpact 'Find Full Moon
        	If (iMoon < 21) Then iMoon = iMoon + 30
        	iMoon = (iMoon + 7 - ((iSunDay + iMoon) Mod 7)) 'advance to sunday
        	If (iMoon > 31) Then
        		iMonth = 4
        		iDay = (iMoon - 31)
        	Else
        		iMonth = 3
        		iDay = iMoon
        	End If
        	df_Easter = DateSerial(iYear, iMonth, iDay)
        Else
            df_Easter = False
        End If
    Else
        df_Easter = False
    End If
End Function

Function df_IsLeapyear (ByVal iYear)
    'returns True if the year indicated by iYear is a leap year, false if not
    'or -2 if iYear is not in the range of 0 .. 9999
    If IsNumeric(iYear) Then
        iYear = CInt(iYear)
        If (iYear >= 0) And (iYear <= 9999) Then
            If (iYear Mod 4) = 0 Then
                If (iYear Mod 100) = 0 Then
                    If (iYear Mod 400) = 0 Then
                        df_IsLeapyear = True
                    Else
                        df_IsLeapyear = False
                    End If
                Else
                    df_IsLeapyear = True
                End If
            Else
                df_IsLeapyear = False
            End If
        Else
            df_IsLeapyear = -2
        End If
    Else
        df_IsLeapyear = -2
    End If
End Function

Function df_ISOWeekday (ByVal dDate)
    'returns the ISO weekday number (Monday = 0 .. Sunday = 6)
    'or -1 for invalid dates
    Dim iDay
    If IsDate(dDate) Then
        iDay = Weekday(dDate, vbSunday) 'this is the default, but we set it to make it clearer
        If iDay = 1 Then iDay = iDay + 7 '1 means Sunday
        df_ISOWeekday = iDay - 2 'offset the VB weekday to the ISO weekday
    Else
        df_ISOWeekday = -1
    End If
End Function

Function df_ISOWeek (ByVal dDate)
    'returns the ISO week number (week 1 is the week that contains the 4th of January / Monday is the first day of the week)
    'or -1 for invalid dates
    If IsDate (dDate) Then
        df_ISOWeek = DatePart("ww", dDate, vbMonday, vbFirstFourDays)
    Else
        df_ISOWeek = -1
    End If
End Function

Function df_Monthname (ByVal iMonth, ByVal sLanguage)
    'returns the name of the month indicated by iMonth (with January = 1) in the language indicated by sLanguage
    'or the null string for invalid months
    'sLanguage codes according to ISO 639 two-letter codes
    Dim sMonthnames
    If IsNumeric(iMonth) Then
        iMonth = CInt(iMonth)
        If (iMonth >= 0) And (iMonth <= 12) Then
            Select Case UCase(sLanguage)
                Case "DE" 'german
                    sMonthnames = Split("Januar Februar März April Mai Juni Juli August September Oktober November Dezember")
                Case "FR" 'french
                    sMonthnames = Split("Janvier Fevrier Mars Avril Mai Juin Juillet Aout Septembre Octobre Novembre Dicembre")
                Case "IT" 'italian
                    sMonthnames = Split("Gennaio Febbraio Marzo Avrile Maggio Giugno Luglio Agosto Settembre Ottobre Novembre Dicembre")
                Case "ES" 'spanish
                    sMonthnames = Split("Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Diciembre")
                Case Else 'english
                    sMonthnames = Split("January February March April May June July August September October November December")
            End Select
            df_Monthname = sMonthnames(iMonth - 1)
        Else
            df_Monthname = ""
        End If
    Else
        df_Monthname = ""
    End If
End Function

Function df_SQLDate (ByVal dDate)
    'returns a date in the SQL #m/d/y# format, or the null string for invalid dates
    If IsDate(dDate) Then
        df_SQLDate = "#" & Month(dDate) & "/" & Day(dDate) & "/" & Year(dDate) & "#"
    Else
        df_SQLDate = ""
    End If
End Function

Function df_Weekdayname (ByVal iDay, ByVal sLanguage)
    'returns the name of the weekday indicated by iDay (with Monday = 0) in the language indicated by sLanguage
    'or the null string for invalid days
    'sLanguage codes according to ISO 639 two-letter codes
    Dim sDaynames
    If IsNumeric(iDay) Then
        iDay = CInt(iDay)
        If (iDay >= 0) And (iDay <= 6) Then
            Select Case UCase(sLanguage)
                Case "DE" 'german
                    sDaynames = Split("Montag Dienstag Mittwoch Donnerstag Freitag Samstag Sonntag")
                Case "FR" 'french
                    sDaynames = Split("Lundi Mardi Mercredi Jeudi Vendredi Samedi Dimanche")
                Case "IT" 'italian
                    sDaynames = Split("Lunedì Martedì Mercoledì Giovedì Venerdì Sabato Domenica")
                Case "ES" 'spanish
                    sDaynames = Split("Lunes Martes Miercoles Jueves Viernes Sabado Domingo")
                Case Else 'english
                    sDaynames = Split("Monday Tuesday Wednesday Thursday Friday Saturday Sunday")
            End Select
            df_Weekdayname = sDaynames(iDay)
        Else
            df_Weekdayname = ""
        End If
    Else
        df_Weekdayname = ""
    End If
End Function

'Test the date functions
sTest = "Easter date for " & Year(Date) & " = " & df_Easter(Year(Date)) & vbCr
sTest = sTest & "Leap year test for 2000: " & df_IsLeapyear(2000) & vbCr
sTest = sTest & "ISO Weekday number for today = " & df_ISOWeekday(Date) & vbCr
sTest = sTest & "ISO Weekday number for 19.1.2002 = " & df_ISOWeekday(DateValue("1/19/2002")) & vbCr
sTest = sTest & "ISO Week number for today = " & df_ISOWeek(Date) & vbCr
sTest = sTest & "German month name for today = " & df_Monthname(Month(Date), "DE") & vbCr
sTest = sTest & "SQL Date string for today = " & df_SQLDate(Date) & vbCr
sTest = sTest & "SQL Date string for 19.1.2002 = " & df_SQLDate(DateSerial(2002, 1, 19)) & vbCr
sTest = sTest & "Spanish day name for today = " & df_Weekdayname(df_ISOWeekday(Date), "ES")
MsgBox sTest, vbOkOnly, "Date Functions Test"
