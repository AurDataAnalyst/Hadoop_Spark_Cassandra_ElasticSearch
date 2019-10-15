
public abstract class Arbre
{
    /* Les champs sont
     *  0: Geo point
     *  1: ARRONDISSEMENT
     *  2: GENRE
     *  3: ESPECE
     *  4: FAMILLE
     *  5: ANNEE PLANTATION
     *  6: HAUTEUR
     *  7: CIRCONFERENCE
     *  8: ADRESSE
     *  9: NOM COMMUN
     * 10: VARIETE
     * 11: OBJECTID
     * 12: NOM_EV
     */
    static String[] champs;

    public static void fromLine(String ligne)
    {
        champs = ligne.split(";");
    }

    public static String getGenre()
    {
        return champs[2];
    }

    public static double getAnnee() throws Exception
    {
        return Double.parseDouble(champs[5]);
    }

    public static double getHauteur() throws Exception
    {
        return Double.parseDouble(champs[6]);
    }
}
