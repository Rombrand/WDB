import java.util.Scanner;


public class DateTimeToUnixTime
{
	
	/** Datum+Zeit in Unix-Zeit.
	 */
	private long unixzeit(int jahr, int monat, int tag, int stunde, int minute, int sekunde)
	{
		/* Anzahl der Tage seit Jahresanfang ohne Tage des aktuellen Monats und ohne Schalttag */
		short tage_seit_jahresanfang[] = {0,31,59,90,120,151,181,212,243,273,304,334};
		int schaltjahre = ((jahr-1)-1968)/4 /* Anzahl der Schaltjahre seit 1970 (ohne das evtl. laufende Schaltjahr) */
	                  - ((jahr-1)-1900)/100
	                  + ((jahr-1)-1600)/400;

		long tage_seit_1970 = (jahr-1970)*365 + schaltjahre + tage_seit_jahresanfang[monat-1] + tag-1;

		if ( (monat>2) && (jahr%4==0 && (jahr%100!=0 || jahr%400==0)) )
			tage_seit_1970 += 1; /* +Schalttag, wenn jahr Schaltjahr ist */
		
		return sekunde + 60 * ( minute + 60 * (stunde + 24*tage_seit_1970) );
	}

	/**
	 * @param args
	 */
	public static void main(String[] args)
	{
		Scanner reader = new Scanner(System.in);
		System.out.println("Enter a number: ");
		int n = reader.nextInt();
		
		DateTimeToUnixTime test = new DateTimeToUnixTime();
		System.out.println(test.unixzeit(2016, 12, 6, 12, 30, 1));

	}

}
