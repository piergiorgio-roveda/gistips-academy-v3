# Riconoscere se è necessario un GIS al proprio scopo

### Indice

1. È necessario un GIS al proprio scopo?

**Section Goal**

> Middle Section Intro: what will they learn, how will they learn? How will you wrap up and transition?

> Sezioni: concentrati su una sola competenza nuova e pertinente per ogni sezione. Assicurati che tutte le sezioni contribuiscano a fornire le competenze promesse negli obiettivi del corso. Lezioni: ogni sezione deve contenere, idealmente, 3-5 lezioni. Tratta un solo concetto per lezione in modo da consentire agli studenti di fare progressi ogni tot lezioni. In genere, un video non deve essere più lungo di 2-6 minuti. Per creare video efficaci, scegli il formato appropriato, basato sul tipo di contenuto che vuoi presentare. Attività pratica: includi almeno 1 esercizio pratico per sezione in modo da dare agli studenti la possibilità di mettere in pratica le competenze/le nozioni apprese nella sezione. Man mano che crei il corso, inserisci progetti, quiz ed esercizi per aiutare gli studenti a fare pratica e a sviluppare i concetti che hanno appreso. Materiali di riferimento: non dimenticare di annotare eventuali ulteriori risorse che desideri aggiungere in ogni sezione, come checklist, fogli di lavoro, modelli, supporti visivi, appunti in formato PDF e collegamenti aggiuntivi, in base alle necessità.

### Perchè usare i GIS rispetto ad altri software

| key      | value                                              |
| -------- | -------------------------------------------------- |
| Format   | _Abc..._                                           |
| Activity | _Abc..._                                           |
| Resource | _Abc..._                                           |
| Notes    | _Abc..._(content, script notes, visual cues, etc.) |

**Est. Time : 0 Min.**

Durante il laboratorio di Urbanistica eravamo suddivisi in due macro gruppi: da una parte chi studiava il PRG di Roma e dall'altra chi faceva "zooning" di un quartiere di Milano. Io ero in questo secondo e usavo AutoCAD. In una prima parte del laboratorio avevamo imparato il Decreto interministeriale 1444 del 1968, dove si parlava principalmente di standard urbanistici: 9 mq/ab per parchi, 4,5 mq/ab per istruzione e così via.

Conoscevo bene il AutoCAD, ma anche Excel e non era complicato fare i conti delle aree disegnate col CAD, con qualche formula in Excel. E poi ero appassionato di disegno tecnico e 3D, ma l'aggiornamento dei conteggi ad ogni piccola modifica su AutoCAD, dovevo sempre riportarla in Excel.

In qualche forum leggevo che si poteva leggere i dati di un disegno di Autocad in Excel, ma non ci sono mai riuscito.

Mi affacciai più volte ai miei compagni del primo gruppo, immaginando che il loro problema fosse ben più ampio del mio, visto che loro avevano una città e io solo un quartiere, ma ho subito scoperto che a loro non erano richiesti calcoli, ma solo tavole presentabili e utilizzavano tutti Illustrator.

Dimenticato il gruppo di Roma, torno al mio Excel, dove i grafici e le tabelle aumentano, ma gli aggiornamenti dei dati erano troppo scomodi e il 3D troppo intrigante.

Le funzioni allettanti quando si utilizza un GIS, che spiego nella prossima parte, possono essere una delle motivazioni di scelta dei GIS e assegnerò ad ogni funzione una valutazione o di necessità o alternativa, nell'utilizzo dei GIS. L'esempio però che ho riportato ha però una precisa logica. Se non capisci questa logica, preferisco che non prosegui con le prossime parti e mi contatti.

Infatti l'intento del corso non è quello di dimostrare ai colleghi di sapere utilizzare il GIS o di acquisire qualche credito; soprattutto la mia personale missione è sia quella di insegnare i GIS, che quella di svelare i limiti dei GIS, per riuscire più semplicemente ad usare svariati software e integrarli tra di loro.

Con gli anni, tornando al mio esempio, ho imparato benissimo a fare i grafici e belle tabelle collegati alle geometrie, usando solo il GIS, ma la vera soddisfazione è stata quella di collegare Excel con il GIS far fare ad Excel ciò che nessun altro software riuscirà mai a fare meglio: grafici e tabelle!

### Funzioni principali di un GIS

| key      | value                                              |
| -------- | -------------------------------------------------- |
| Format   | _Abc..._                                           |
| Activity | _Abc..._                                           |
| Resource | _Abc..._                                           |
| Notes    | _Abc..._(content, script notes, visual cues, etc.) |

**Est. Time : 0 Min.**

#### Visualizzazione e personalizzazione grafica dei dati geografici

I dati geografici, distribuiti di solito col formato Shapefile, ma anche GPX, Geojson, KML, per conformità, possono essere aperti solo da software GIS oppure da altri software con dei plugin aggiuntivi che hanno funzioni GIS. Il motivo di questa unicità, deriva dal fatto che i dati geografici sono composti obbligatoriamente da una geometria e da una tabella di dati alfa-numerici. Se i dati geografici comunemente usati, solo se scomposti possono essere usati con altri software. I tipi di geometria possono vettoriali (punti, linee, poligoni) oppure raster. Le curve, le mesh e il 3D, riguardano delle funzionalità GIS meno comuni, che non verranno trattate in questo o in altri corsi tenuti dal sottoscritto.

Parlando dei dati geografici di tipo vettoriale, è possibile assegnare uno stile personalizzato alla geometrie; per chi conosce i software di grafica, meglio se si fa riferimento a Inkscape o Illustrator, ogni singola geometria può essere colorata, i punti possono diventare dei simboli di vario tipo e colore, le linee possono essere più spesse, tratteggiate o con effetti di ombreggiatura o neon style ed infine i poligoni possono avere un bordo, con le proprietà delle linee ed un riempimento di tipo uniforme con canale alpha modificabile con un pattern. La differenza tra i software grafici puri e i GIS, che le geometrie a cui assegnare uno stile definito, non sono scelte a mano, ma in base agli attributi. Ad esempio si possono colorare tutti i comuni di una provincia di rosso e tutti i comuni di una seconda provincia di verde.

#### Modifica dei dati geografici

Per scoprire a fondo questa funzionalità, non obbligatoria neanche per tutti i GIS, bisogna fare riferimento al puro disegno vettoriale, meglio ai software CAD, piuttosto che Illustrator o Inkscape. Infatti la creazione o lo spostamento di un punto, operazione elementare, ha le stesse caratteristiche funzionali di quando si muove un punto su AutoCad, tanto da dedicare ai software CAD, la realizzazione del "disegno" vettoriale, per molti anni. Un punto è caratterizzato da una coppia di numeri che indicano la sua posizione su un piano. Con questa logica, inserire un punto a 2 metri dal muro sinistro di una stanza e a 3 metri dal muro a ... Sud ... Quando gli spazi sono piccoli, l'errore dovuto al fatto che la terra non è piatta, è praticamente irrilevante, quando invece si inizia ad utilizzare il punto 0,0 di riferimento a quasi un miliaio di km, tipo Monte Mario, che la terra sia piatta o meno, fa la differenza. I GIS a differenza dei CAD, hanno la funzionalità descritta di seguito e possono gestire gli algoritmi per la gestione dei sistemi di coordinate. I GIS recentemente hanno integrato gli strumenti CAD, unendoli alla gestione dei sistemi di coordinate, così da poter disegnare la città di Sidney e la città di New York, che hanno sistemi di coordinate diversi, sulla stessa mappa. Ogni volta che creo un punto o lo sposto, automaticamente le nuove coordinate vengono registrate all'interno del dati geografico, così per le linee, vengono registrate le coordinate di tutti i vertici che la compongono, la loro sequenza e anche la lunghezza mentre per i poligoni si aggiunge l'area.

Come potete notare, anche queste ultime caratteristiche sono registrate in automatico nei CAD, quindi i GIS in questo caso, possono avere un'alternativa.

#### Gestione dei sistemi di coordinate e delle scale

Come anticipato nessuno mi vieta di disegnare un quadrato attorno ad un Comune (tecnicamente viene definito "estensione" o "bbox" del poligono), ma il calcolo della superficie o del perimetro, può essere differente tra un sistema di coordinate e l'altro, se non addirittura vederlo espresso in "gradi". a livello di sistema, non c'è nessun problema, ma se qualcuno vi chiede la lunghezza di una autostrada, bisogna prima scegliere il sistema di riferimento corretto, prima di dare una risposta.

Questa funzionalità, unica dei GIS, seppur descritta velocemente, avrebbe bisogno di una parte del corso dedicata. Però nella situazione moderna dei software e dei dati, non risulta essere più obbligatoria conoscerla per proseguire nell'utilizzo dei GIS.

#### Creazione di mappe per la stampa

Sembra obsoleto parlare di mappe cartacee, ma non è così. La richiesta di un PDF ad una determinata scala, su un foglio di dimensione standard è all'ordine del giorno in alcuni settori. Esportare la vista della mappa in una immagine, per poi impaginarla con software grafici come GIMP o Photoshop, è un'operazione eseguibile in pochi click. Anche per questa fnzionalità, negli anni recenti, la comodità di avere una gestione di Layout per la stampa, dove si possono inserire immagini, testi, legenda e altri elementi cartografici è diventata una parte integrata dei comuni GIS.

Per capire meglio l'importanza di gestire i layout di stampa all'interno del GIS, c'è una piccola storia: ArcGIS è stato il primo GIS che ha inserito delle funzioni di Illustrator e altre da Autocad, per disegnare le mappe, anche più mappe nello stesso layou, con diverse didascalie, stili e legende. Col passare degli anni, gli sviluppatori di QGIS, si sono sempre ispirati ad ArcGIS, ma gli utenti esperti di questo, hanno sempre snobbato e cercato di confondere gli utenti di QGIS alle prime armi. Gli sviluppatori di QGIS continuano tuttora a migliorare sempre di più il software, inserendo sempre più funzionalità, ma la grande differenza è stata fatta con il miglioramento del layout di stampa, chiamato "compositore", che oggi è talmente sofisticato, che a volte diventa difficile da usare dalle svariate possibilità che mette a disposizione. Gli utenti esperti di ArcGIS, pur vedendo svanire l'ultima funzionalità in cui primeggiava il loro amato software, continuano a ritenerlo il migliore.

Roberto SilvestriFollow Aree di Emergenza Elaborato relativo al Piano di Emergenza Comunale - Regione Veneto https://www.flickr.com/photos/155056015@N07/34647847870/in/pool-qgis/

Alejandro LepeFollow Precio M2 Transporte público https://www.flickr.com/photos/155164863@N07/23624900278/in/pool-qgis/

#### Modifica dei dati, anche con informazioni geografiche

Come in Excel, ogni riga della tabella si può modificare a mano o con formule. Forse è sbagliato paragonarlo ad Excel, perchè la struttura è fissa e quindi è più simile ad un database o ad una tabella di Access. A volte rimane comunque comodo modificare la tabelle dei dati geografici in Excel o in Access, ma bisogna sempre ricordarsi, che la tabella che ogni dato geografico possiede, è legata in modo univoco alle geometrie. Rimanendo invece a modificare la tabella nei GIS, abbiamo la funzionalità di usare la componente geometrica nelle formule. Oltre a riempire una colonna con la superficie, possiamo usare questa per calcolare la densità per km2. Le formule, in questo caso chiamate anche indici urbanistici o geostatistici, spesso includono valori derivanti dalle geometrie. Torna utile il calcolo geometrico anche per trovare eventuali errori, che per le funzionalità successive, sono da evitare il più possibile.

#### Relazionare le tabelle tramite campi comuni o Join (1:1, 1:n, n:n)

Direttamente dalle funzioni dei database relazionali, nei GIS sono implementate le funzionalità per mettere in relazione i dati delle geometrie. Ho notato che questo argomento è complicato per la maggior parte degli utilizzatori GIS, anche se hanno un po' di esperienza. Queste relazioni nascono dall'esigenza di ottimizzare i dati, evitando in primo luogo la duplicazione delle informazioni, ma anche per rendere le tabelle più leggere, anche se la difficoltà di lettura potrebbe essere compromessa.

#### Interrogazioni spaziali (geometriche, geografiche e topologiche)

Le interrogazioni di tipo spaziale sono funzioni che abilitano la possibilità di ottenere informazioni dalle geometrie e tra la loro posizione nello spazio.

Le interrogazioni geometriche rappresentano le caratteristiche spaziali con sistemi di coordinate planari, mentre quelle geografiche rappresentano le caratteristiche spaziali con sistemi di coordinate geodetiche (ellissoidali), basandosi sul sistema descritto nella parte di "modifica dei dati geografici", dove viene spiegata la differenza tra CAD e GIS.

Le interrogazioni topologiche invece trattano gli oggetti geometrici come degli insiemi. Ad esempio se disegno una linea retta da un punto A ad un punto B, topologicamente conosco anche la direzione, mentre geometricamente conosco solo le coordinate dei punti A e B.

Se per le interrogazioni spaziali di tipo geometrico e geografico siamo più portati a capire le funzioni, è normale, rispetto alle funzioni topologiche. Per questo motivo seguirà un corso dedicato a questo tipo di interrogazioni.

Se volessi calcolare quanti comuni ci sono in una provincia, con Access e con la colonna "provincia" nel layer "comuni", my basterebbe fare una semplice interrogazione. Nel caso però mi vengono consegnati dei nuovi confini proviciali, per ricontare i comuni in più o in meno per ogni provincia, utilizzando le le interrogazioni spaziali, questo è possibile in pochi click. Lo strumento di di selezione, uno dei più usati nei GIS, può essere di tipo puntuale, areale, circolare, a mano libera oppure tramite geometria. Quindi è possibile interrogare o selezionare un layer, utilizzando l'intersezione con un altro layer.

Lee and Hsu have also brought there reasoning mechanism even further by taking the relations pairwise into account, i.e. by combining binary relations along both coordinate axes. Hence, it has been possible to identify 169 different types of spatial relations in two dimensions, which can be seen in Table 4.13. https://people.cs.pitt.edu/\~chang/365/images/table53.gif

#### Analisi spaziali (geografiche e topologiche)

Rispetto alle interrogazioni, le analisi spaziali, seguono dei modelli con algoritmi definiti, oppure sono personalizzate unendo sia gli algoritmi esistenti con le interrogazioni spaziali.

Per riportare un esempio di analisi spaziale, possiamo pensare alla funzione di calcolo del tragitto da un punto A ad un punto B, seguendo le strade. Questo esempio è un'analisi spaziale del gruppo delle analisi di rete. Un altra analisi, chiamata Cluster ci permette di visualizzare punti localizzati vicini, come dei punti più grossi raggruppati, oppure le famose mappe di calore, che possono indicare la presenza alta o bassa di punti o dei loro valori. Lo stesso modello digitale del terreno, molto utilizzato in 3D, risulta una analisi spaziale, che aggrega i punti vicini e stima una quota.

#### Geoprocessing

Queste funzionalità sono molto diffuse nei programmi di grafica vettoriale come Inkscape e Illustrator. Si tratta delle funzioni di union, intersect, clip e merge. Per chi, come me, spesso gestirà i file vettoriali, gli strumenti di geoprocessing è utile impararli il prima possibile.

Queste funzioni sono lo strumento principale per l'editing delle geometrie. Nei GIS, risulta interessante anche capire come queste funzioni agiscono sui dati. Infatti se unisco due geometrie, non solo aumenta la superficie, ma anche i dati contenuti, andrebbero sommati, ad esempio se unisco due quartieri, la popolazione riportate nelle 2 geometrie, dovrà essere sommata. Tutto si complica quando le 2 geometrie hanno una parte sovrapposta, ma in questo caso si può ricorre al calcolo della percentuale sovrapposto e fare la media.

#### Gestione e analisi cartografie raster (o immagini)

In molti ambiti applicativi i raster, sono il dato geografico maggiormente utilizzato. I GIS più diffusi, gestiscono leggono i raster, come le ortofoto in modo semplice, ma la gestione dei raster, risulta essere molto complessa. Infatti i GIS, offrono la possibilità di leggere immagini di dimensioni molto elevate, usando degli algoritmi, per velocizzare la visualizzazione. Interessante è anche la possibilità di visualizzare tanti raster, suddivisi in griglie, come ad esempio le vecchie CTR del 1994.

Ma c'è qualcosa di più della semplice visualizzazione. I file raster utilizzati nei GIS, hanno nella loro (colorazione) dei dati, ad esempio un certo numero di pixel, vicini tra lore di colore verde, potrebbero essere un bosco, oppure il riflesso di uno stagno. Le tecniche di analisi dei raster, sono spesso raggruppate nelle operazioni di Remote sensing.
