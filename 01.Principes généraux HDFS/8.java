public abstract class Station
{
    static String ligne;

    public static void fromLine(String ligne)
    {
        Station.ligne = ligne;
    }

    public static String getNom() throws IndexOutOfBoundsException
    {
        return ligne.substring(13, 13+29);
    }

    public static Double getAltitude()
        throws IndexOutOfBoundsException, NumberFormatException
    {
        return Double.parseDouble(ligne.substring(74, 74+7));
    }
}
