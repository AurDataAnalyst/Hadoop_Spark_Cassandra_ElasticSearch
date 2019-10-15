public static double getDewPoint() throws Exception
{
    // qualité
    char quality = ligne.charAt(98);
    if ("01459ACIMPRU".indexOf(quality) < 0) throw new Exception();
    // valeur absolue
    String temp = ligne.substring(94, 94+4);
    if ("9999".equals(temp)) throw new Exception();
    // signe et conversion en nombre
    char signe = ligne.charAt(93);
    return Integer.parseInt(temp) * (signe=='-'?-0.1:0.1);
}
