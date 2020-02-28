class MaClasse(object):

    # constructeur
    def __init__(self, param1, param2):
        self.membre1 = param1
        self.membre2 = param2

    # affichage (equivalent de toString())
    def __str__(self):
        return "MaClasse['%s', %s]" % (self.membre1, self.membre2)

    # accesseur
    def getMembre1(self):
        return self.membre1

instance = MaClasse("pi", 3.1415);
print instance
print instance.getMembre1()
