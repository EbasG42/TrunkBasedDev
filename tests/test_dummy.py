import sys
import os
sys.path.append(os.path.abspath("./src"))
import archivo_prueba

def test_suma():
    assert archivo_prueba.suma(2, 3) == 5
