# umintCV6

1. Pomocou genetického algoritmu navrhnite parametre PID regulátora pre riadenie 
nelineárneho dyn. systému z minulého zadania.  Ohraničenie riadiacej veličiny regulátora 
zvoľte tak, aby veľkosť riadiacej veličiny zodpovedala dvojnásobku ustálenej hodnoty výstupu 
riadeného systému v hodnote 4 (pozri prevodovú char. systému). Ohraničenie hľadaných 
parametrov PID zvoľte na max. 10 000. Použite genetický algoritmus vytvorený na 
predchádzajúcich cvičeniach, kde vyhodnotenie fitness funkcie predstavuje nasledovná 
sekvencia, ktorá sa realizuje pre každý reťazec (jedinca) populácie:  
• priradenie hodnôt z aktuálneho jedinca populácie do premenných P,I,D, ktoré sa 
nachádzajú v simulinkovej schéme v PID regulátore (regulátor v schéme bude 
obsahovať premenné, nie konštanty).  
• spustenie simulácie v Simulinku príkazom sim(‘meno_schemy’)  
• výpočet integrálneho kritéria kvality regulácie IAE (viď prednášky), čo je hodnota 
fitness funkcie daného jedinca. 
Návrh realizujte pre skok žiadanej hodnoty z 0 na 3 a následne z 3 na 1. V simulinkovej schéme 
je potrebné nastaviť pevný krok simulácie o vhodnej veľkosti. Krok simulácie zvoľte tak, aby 
ste uskutočnili počas jedného prechodného deja nahor resp. nadol aspoň 200 vzoriek simulácie. 
Vhodne zvoľte čas simulácie, aby sa stihli uskutočniť všetky predpísané skoky, ale aby systém 
zbytočne nezotrvával dlho v ustálenom stave. Simulácia sa bude totiž počas behu GA spúšťať 
mnoho krát, čo bude časovo náročné. 
2. Uskutočnite opatrenie, aby ste potlačili eventuálne preregulovanie a oscilácie regulovanej 
veličiny. Podmienka pre max. preregulovanie je 10% od žiadanej hodnoty. Riešenie nájdite 
v prednáškach. Výsledok regulácie porovnajte s predchádzajúcim bodom zadania. 
Poznámky: 
1. Pre oba body zadania vykreslite do troch obrázkov: 1. priebeh evolúcie fitness funkcie, 2. 
priebeh regulovanej veličiny (y) + žiadanej hodnoty (w) a 3. priebeh riadiacej veličiny (u). 
2. Na zabezpečenie odolnosti voči „padaniu“ výpočtu z dôvodu numerickej nestability 
simulácie použite príkazy „try/catch“.

<img width="1812" height="1202" alt="image" src="https://github.com/user-attachments/assets/d090c41c-03f0-4dea-9d68-5e03584877bf" />

<img width="1869" height="805" alt="image" src="https://github.com/user-attachments/assets/fdde9ebb-c986-42c3-843b-1e76b366cf64" />

<img width="1394" height="645" alt="image" src="https://github.com/user-attachments/assets/93b1c3d7-531b-4354-b460-53e93291b4ff" />


