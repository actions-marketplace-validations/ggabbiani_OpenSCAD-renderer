$fn = 60; // Definizione della qualità dei cilindri

// 1. DEFINIZIONE DELL'OGGETTO (Data Object)
// Creiamo un "oggetto" che racchiude tutti i parametri di una flangia
flangia_config = object(
    diametro_esterno = 80,
    spessore = 10,
    diametro_albero = 30,
    num_fori = 4,
    diametro_fori = 8
);

// 2. FUNZIONE MATEMATICA CHE USA L'OGGETTO
// Calcola la distanza ottimale dei fori dal centro (interasse) basandosi sul diametro esterno
function calcola_interasse(obj) = (obj.diametro_esterno + obj.diametro_albero) / 4;


// 3. MODULO DI RENDERING
// Questo modulo prende l'oggetto come argomento e genera la geometria 3D
module renderizza_flangia(config) {
    // Calcoliamo l'interasse dei fori usando la funzione di supporto
    raggio_posizione_fori = calcola_interasse(config);

    difference() {
        // Corpo principale della flangia (Diametro Esterno)
        cylinder(d = config.diametro_esterno, h = config.spessore, center = true);

        // Foro centrale per l'albero
        cylinder(d = config.diametro_albero, h = config.spessore + 2, center = true);

        // Generazione dinamica dei fori di fissaggio usando le proprietà dell'oggetto
        if (config.num_fori > 0) {
            for (i = [0 : config.num_fori - 1]) {
                angolo = i * (360 / config.num_fori);

                // Ruotiamo e spostiamo ogni foro basandoci sui dati dell'oggetto
                rotate([0, 0, angolo])
                translate([raggio_posizione_fori, 0, 0])
                cylinder(d = config.diametro_fori, h = config.spessore + 2, center = true);
            }
        }
    }
}

// 4. CHIAMATA DI RENDERING
// Passiamo l'oggetto "flangia_config" direttamente al modulo per il rendering finale
renderizza_flangia(flangia_config);


// --- DIMOSTRAZIONE DI EREDITARIETÀ/SOVRASCRITTURA ---
// Se volessimo fare una variante "LARGE" della stessa flangia, possiamo creare
// un secondo oggetto che copia il primo ma sovrascrive solo il diametro e i fori:
/*
flangia_grande = object(flangia_config, diametro_esterno = 120, num_fori = 6);

translate([150, 0, 0]) // Spostiamola a lato per non sovrapporla
renderizza_flangia(flangia_grande);
*/