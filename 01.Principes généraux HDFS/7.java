public abstract class Arbre
{
    static String[] champs;

    public static void fromLine(String ligne)
    {
        champs = ligne.split(";");
    }

    public static double getAnnee() throws NumberFormatException
    {
        return Double.parseDouble(champs[5]);
    }
}
