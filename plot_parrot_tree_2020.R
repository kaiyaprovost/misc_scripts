## this file makes Figure S2 the large backbone tree with smaller subtrees 
## it is not just for raxml boots anymore but displayes the PP from exabayes

library(ape)
library(phytools)
library(ggtree) ## 
library(diversitree)
library(geiger)
library(RColorBrewer)


tree1 = "/Users/kprovost/Dropbox (AMNH)/no_filtering_all_samples_concatenated.contree.relabel.txt"
tree2 = "/Users/kprovost/Dropbox (AMNH)/24_july_2020_all_species_gene_BS10.astral.species.tre.relabel.txt"

tree1_original = "/Users/kprovost/Dropbox (AMNH)/no_filtering_all_samples_concatenated.contree.txt"
tree2_original = "/Users/kprovost/Dropbox (AMNH)/24_july_2020_all_species_gene_BS10.astral.species.tre.txt"

input1 = read.tree(tree1)
input2 = read.tree(tree2)

input1_o = read.tree(tree1_original)


plot.phylo(input1,cex=0.3,type="radial")


## GENUS
{Acanthisitta=c("Acanthisitta_chloris")
 Agapornis=c("Agapornis_canus","Agapornis_fischeri","Agapornis_lilianae","Agapornis_nigrigenis",       "Agapornis_personatus","Agapornis_pullarius","Agapornis_roseicollis","Agapornis_swindernianus","Agapornis_taranta")
 Alipiopsitta=c("Alipiopsitta_xanthops")
 Alisterus=c("Alisterus_amboinensis","Alisterus_chloropterus","Alisterus_scapularis")
 Amazona=c("Amazona_aestiva","Amazona_agilis","Amazona_albifrons","Amazona_amazonica","Amazona_diadema",      "Amazona_guatemalae",      "Amazona_mercenarius",      "Amazona_tresmariae",      "Amazona_xantholora",      "Amazona_arausiaca","Amazona_auropalliata","Amazona_autumnalis","Amazona_barbadensis","Amazona_brasiliensis",      "Amazona_collaria","Amazona_dufresniana","Amazona_farinosa","Amazona_festiva","Amazona_finschi","Amazona_guildingii","Amazona_imperialis","Amazona_kawalli","Amazona_leucocephala","Amazona_ochrocephala","Amazona_oratrix","Amazona_pretrei","Amazona_rhodocorytha","Amazona_tucumana","Amazona_ventralis","Amazona_versicolor","Amazona_vinacea","Amazona_viridigenalis","Amazona_vittata")
 Anodorhynchus=c("Anodorhynchus_hyacinthinus","Anodorhynchus_glaucus","Anodorhynchus_leari")
 Aprosmictus=c("Aprosmictus_erythropterus","Aprosmictus_jonquillaceus")
 Ara=c("Ara_ambiguus","Ara_ararauna","Ara_chloropterus","Ara_glaucogularis","Ara_macao","Ara_militaris","Ara_rubrogenys","Ara_severus","Ara_cyanopterus","Ara_macao_cyanopterus")
 Aratinga=c("Aratinga_auricapillus","Aratinga_jandaya","Aratinga_maculata","Aratinga_nenday","Aratinga_solstitialis","Aratinga_weddellii")
 Barnardius=c("Barnardius_zonarius","Barnardius_barnardi")
 Bolbopsittacus=c("Bolbopsittacus_lunulatus")
 Bolborhynchus=c("Bolborhynchus_lineola","Bolborhynchus_ferrugineifrons",         "Bolborhynchus_orbygnesius")
 Brotogeris=c("Brotogeris_chiriri","Brotogeris_chrysoptera","Brotogeris_cyanoptera","Brotogeris_jugularis",        "Brotogeris_pyrrhoptera","Brotogeris_sanctithomae","Brotogeris_tirica","Brotogeris_versicolurus","Brotogeris_chrysopterus")
 Cacatua=c("Cacatua_alba","Cacatua_ducorpsii","Cacatua_galerita","Cacatua_goffiniana","Cacatua_haematuropygia","Cacatua_moluccensis",      "Cacatua_ophthalmica","Cacatua_pastinator","Cacatua_sanguinea","Cacatua_sulphurea","Cacatua_tenuirostris")
 Charminetta=c("Charminetta_wilhelminae") 
 Callocephalon=c("Callocephalon_fimbriatum")
 Calyptorhynchus=c("Calyptorhynchus_banksii","Calyptorhynchus_baudinii","Calyptorhynchus_funereus","Calyptorhynchus_lathami","Calyptorhynchus_latirostris")
 Chalcopsitta=c("Chalcopsitta_atra","Chalcopsitta_duivenbodei","Chalcopsitta_scintillata")
 Charmosyna=c("Charmosyna_meeki","Charmosyna_multistriata","Charmosyna_papou","Charmosyna_placentis","Charmosyna_pulchella","Charmosyna_rubronotata","Charmosyna_josefinae")
 Charmosynoides=c("Charmosynoides_margarethae") 
 Charmosynopsis=c("Charmosynopsis_pulchella", "Charmosynopsis_toxopei") 
 Conuropsis=c("Conuropsis_carolinensis")
 Coracopsis=c("Coracopsis_nigra","Coracopsis_vasa", "Coracopsis_barklyi","Coracopsis_niger")
 Cyanoliseus=c("Cyanoliseus_patagonus")
 Cyanopsitta=c("Cyanopsitta_spixii")
 Cyanoramphus=c("Cyanoramphus_auriceps","Cyanoramphus_forbesi","Cyanoramphus_cookii","Cyanoramphus_hochstetteri","Cyanoramphus_malherbi","Cyanoramphus_novaezelandiae","Cyanoramphus_saisseti","Cyanoramphus_unicolor")
 Cyclopsitta=c("Cyclopsitta_diophthalma","Cyclopsitta_gulielmitertii")
 Deroptyus=c("Deroptyus_accipitrinus")
 Diopsittaca=c("Diopsittaca_nobilis")
 Eclectus=c("Eclectus_roratus")
 Enicognathus=c("Enicognathus_leptorhynchus","Enicognathus_ferrugineus")
 Eolophus=c("Eolophus_roseicapilla")
 Eos=c("Eos_bornea","Eos_cyanogenia","Eos_histrio","Eos_reticulata","Eos_squamata","Eos_semilarvata")
 Eunymphicus=c("Eunymphicus_cornutus","Eunymphicus_cornotus",        "Eunymphicus_uvaensis")
 Eupsittula=c("Eupsittula_aurea","Eupsittula_cactorum","Eupsittula_canicularis","Eupsittula_nana","Eupsittula_pertinax")
 Falco=c("Falco_mexicanus")
 Forpus=c("Forpus_coelestis","Forpus_conspicillatus","Forpus_cyanopygius","Forpus_modestus","Forpus_passerinus","Forpus_xanthops","Forpus_xanthopterygius", "Forpus_crassirostris","Forpus_spengeli")
 Glossoptilus=c("Glossoptilus_goldiei") 
 Hypocharmosyna=c("Hypocharmosyna_placentis","Hypocharmosyna_rubronotata") 
 Geoffroyus=c("Geoffroyus_heteroclitus","Geoffroyus_geoffroyi",        "Geoffroyus_simplex")
 Glossopsitta=c("Glossopsitta_concinna")
 Graydidascalus=c("Graydidascalus_brachyurus")
 Guaruba=c("Guaruba_guarouba")
 Hapalopsittaca=c("Hapalopsittaca_amazonina","Hapalopsittaca_fuertesi","Hapalopsittaca_melanotis","Hapalopsittaca_pyrrhops")
 Lathamus=c("Lathamus_discolor")
 Leptosittaca=c("Leptosittaca_branickii")
 Lophochroa=c("Lophochroa_leadbeateri")
 Loriculus=c("Loriculus_beryllinus","Loriculus_catamene","Loriculus_galgulus","Loriculus_amabilis",       "Loriculus_aurantiifrons",       "Loriculus_exilis",       "Loriculus_sclateri",       "Loriculus_tener","Loriculus_philippensis","Loriculus_pusillus","Loriculus_stigmatus","Loriculus_vernalis")
 Lorius=c("Lorius_albidinucha","Lorius_chlorocercus","Lorius_domicella","Lorius_garrulus","Lorius_hypoinochrous","Lorius_lory")
 Mascarinus=c("Mascarinus_mascarin")
 Melopsittacus=c("Melopsittacus_undulatus")
 Micropsitta=c("Micropsitta_bruijnii","Micropsitta_finschii","Micropsitta_keiensis","Micropsitta_pusio","Micropsitta_geelvinkiana",        "Micropsitta_meeki")
 Myiopsitta=c("Myiopsitta_monachus","Myiopsitta_fuchsi")
 Nannopsittaca=c("Nannopsittaca_dachilleae","Nannopsittaca_panychlora")
 Neophema=c("Neophema_chrysogaster","Neophema_chrysostoma","Neophema_elegans","Neophema_petrophila","Neophema_pulchella","Neophema_splendida")
 Neopsephotus=c("Neopsephotus_bourkii")
 Neopsittacus=c("Neopsittacus_musschenbroekii","Neopsittacus_pullicauda")
 Nestor=c("Nestor_meridionalis","Nestor_notabilis")
 Northiella=c("Northiella_haematogaster","Northiella_narethae")
 Nymphicus=c("Nymphicus_hollandicus")
 Oreopsittacus=c("Oreopsittacus_arfaki")
 Orthopsittaca=c("Orthopsittaca_manilatus","Orthopsittaca_manilata")
 Ognorhynchus=c("Ognorhynchus_icterotis")
 Parvipsitta=c("Parvipsitta_porphyrocephala","Parvipsitta_pusilla")
 Passer=c("Passer_montanus")
 Pezoporus=c("Pezoporus_flaviventris","Pezoporus_occidentalis","Pezoporus_wallicus")
 Phigys=c("Phigys_solitarius")
 Pionites=c("Pionites_leucogaster","Pionites_melanocephalus")
 Pionopsitta=c("Pionopsitta_pileata","Pionopsitta_pulchra")
 Pionus=c("Pionus_seniloides","Pionus_chalcopterus","Pionus_fuscus","Pionus_maximiliani","Pionus_menstruus","Pionus_senilis","Pionus_sordidus","Pionus_tumultuosus")
 Platycercus=c("Platycercus_adscitus","Platycercus_caledonicus","Platycercus_elegans","Platycercus_eximius","Platycercus_icterotis","Platycercus_venustus")
 Poicephalus=c("Poicephalus_flavifrons",        "Poicephalus_fuscicollis","Poicephalus_cryptoxanthus","Poicephalus_gulielmi","Poicephalus_meyeri","Poicephalus_robustus","Poicephalus_rueppellii","Poicephalus_rufiventris","Poicephalus_senegalus")
 Polytelis=c("Polytelis_swainsonii","Polytelis_alexandrae","Polytelis_anthopeplus")
 Primolius=c("Primolius_auricollis","Primolius_couloni","Primolius_maracana")
 Prioniturus=c("Prioniturus_discurus","Prioniturus_flavicans","Prioniturus_luconensis","Prioniturus_mada","Prioniturus_mindorensis","Prioniturus_montanus","Prioniturus_platenae","Prioniturus_platurus","Prioniturus_verticalis","Prioniturus_waterstradti")
 Probosciger=c("Probosciger_aterrimus")
 Prosopeia=c("Prosopeia_personata",       "Prosopeia_splendens","Prosopeia_tabuensis")
 Psephotellus=c("Psephotellus_dissimilis",         "Psephotellus_pulcherrimus",         "Psephotellus_varius") 
 Psephotus=c("Psephotus_chrysopterygius","Psephotus_dissimilis","Psephotus_haematonotus","Psephotus_pulcherrimus","Psephotus_varius")
 Pseudeos=c("Pseudeos_cardinalis","Pseudeos_fuscata")
 Psilopsiagon=c("Psilopsiagon_aurifrons","Psilopsiagon_aymara")
 Psittacara=c("Psittacara_brevipes","Psittacara_strenuus",        "Psittacara_frontatus",        "Psittacara_rubritorquis","Psittacara_chloropterus","Psittacara_erythrogenys","Psittacara_euops","Psittacara_finschi","Psittacara_holochlorus","Psittacara_leucophthalmus","Psittacara_mitratus","Psittacara_wagleri")
 Psittacella=c("Psittacella_madaraszi",        "Psittacella_modesta","Psittacella_brehmii","Psittacella_picta")
 Psittacula=c("Psittacula_calthorpae",        "Psittacula_caniceps","Psittacula_alexandri","Psittacula_calthrapae","Psittacula_columboides","Psittacula_cyanocephala","Psittacula_derbiana","Psittacula_eques","Psittacula_eupatria","Psittacula_exsul","Psittacula_finschii","Psittacula_himalayana","Psittacula_krameri","Psittacula_longicauda","Psittacula_roseata","Psittacula_wardi")
 Psittaculirostris=c("Psittaculirostris_salvadorii","Psittaculirostris_desmarestii","Psittaculirostris_edwardsii")
 Psittacus=c( "Psittacus_timneh","Psittacus_erithacus")
 Psitteuteles=c("Psitteuteles_goldiei","Psitteuteles_iris","Psitteuteles_versicolor")
 Psittinus=c("Psittinus_cyanurus")
 Psittrichas=c("Psittrichas_fulgidus")
 Purpureicephalus=c("Purpureicephalus_spurius")
 Pyrilia=c("Pyrilia_aurantiocephala","Pyrilia_barrabandi","Pyrilia_caica","Pyrilia_haematotis","Pyrilia_pyrilia","Pyrilia_vulturina","Pyrilia_pulchra")
 Pyrrhura=c("Pyrrhura_albipectus","Pyrrhura_amazonum","Pyrrhura_cruentata","Pyrrhura_frontalis",       "Pyrrhura_griseipectus","Pyrrhura_hoffmanni","Pyrrhura_lepida","Pyrrhura_leucotis","Pyrrhura_melanura","Pyrrhura_molinae",       "Pyrrhura_orcesi","Pyrrhura_perlata","Pyrrhura_pfrimeri","Pyrrhura_picta","Pyrrhura_rhodocephala","Pyrrhura_roseifrons","Pyrrhura_rupicola",       "Pyrrhura_caeruleiceps",       "Pyrrhura_calliptera",       "Pyrrhura_devillei",       "Pyrrhura_egregia",       "Pyrrhura_eisenmanni",       "Pyrrhura_emma",       "Pyrrhura_hoematotis",       "Pyrrhura_lucianii",       "Pyrrhura_peruviana",       "Pyrrhura_snethlageae",       "Pyrrhura_subandina",       "Pyrrhura_viridicata")
 Rhynchopsitta=c("Rhynchopsitta_pachyrhyncha","Rhynchopsitta_terrisi")
 Strigops=c("Strigops_habroptila")
 Synorhacma=c("Synorhacma_multistriata") 
 Saudareos=c("Saudareos_flavoviridis", "Saudareos_iris","Saudareos_johnstoniae","Saudareos_ornatus") 
 Tanygnathus=c("Tanygnathus_lucionensis","Tanygnathus_megalorynchos","Tanygnathus_sumatranus")
 Thectocercus=c("Thectocercus_acuticaudatus","Thectocercus_acuticaudata")
 Touit=c("Touit_batavicus","Touit_purpuratus", "Touit_costaricensis",     "Touit_dilectissimus",     "Touit_huetii",     "Touit_melanotus",     "Touit_stictopterus",     "Touit_surdus")
 Trichoglossus=c("Trichoglossus_chlorolepidotus","Trichoglossus_euteles","Trichoglossus_flavoviridis",         "Trichoglossus_haematodus","Trichoglossus_johnstoniae","Trichoglossus_ornatus","Trichoglossus_capistratuss",         "Trichoglossus_forsteni",         "Trichoglossus_moluccanus_",         "Trichoglossus_rosenbergii",         "Trichoglossus_rubiginosus",         "Trichoglossus_rubritorquis",         "Trichoglossus_weberi")
 Triclaria=c("Triclaria_malachitacea")
 Tyrannus=c("Tyrannus_tyrannus")
 Vini=c("Vini_australis","Vini_peruviana", "Vini_amabilis",     "Vini_kuhlii",     "Vini_meeki",     "Vini_palmarum",     "Vini_rubrigularis",     "Vini_solitarius",     "Vini_stepheni",     "Vini_ultramarina")
 genera=list("Acanthisitta"=Acanthisitta,"Agapornis"=Agapornis,"Alipiopsitta"=Alipiopsitta,"Alisterus"=Alisterus,"Amazona"=Amazona,"Anodorhynchus"=Anodorhynchus,"Aprosmictus"=Aprosmictus,"Ara"=Ara,"Aratinga"=Aratinga,"Barnardius"=Barnardius,"Bolbopsittacus"=Bolbopsittacus,"Bolborhynchus"=Bolborhynchus,"Brotogeris"=Brotogeris,"Cacatua"=Cacatua,"Callocephalon"=Callocephalon,"Calyptorhynchus"=Calyptorhynchus,"Chalcopsitta"=Chalcopsitta,"Charmosyna"=Charmosyna,"Conuropsis"=Conuropsis,"Coracopsis"=Coracopsis,"Cyanoliseus"=Cyanoliseus,"Cyanopsitta"=Cyanopsitta,"Cyanoramphus"=Cyanoramphus,"Cyclopsitta"=Cyclopsitta,"Deroptyus"=Deroptyus,"Diopsittaca"=Diopsittaca,"Eclectus"=Eclectus,"Enicognathus"=Enicognathus,"Eolophus"=Eolophus,"Eos"=Eos,"Eunymphicus"=Eunymphicus,"Eupsittula"=Eupsittula,"Falco"=Falco,"Forpus"=Forpus,"Geoffroyus"=Geoffroyus,"Glossopsitta"=Glossopsitta,"Graydidascalus"=Graydidascalus,"Guaruba"=Guaruba,"Hapalopsittaca"=Hapalopsittaca,"Lathamus"=Lathamus,"Leptosittaca"=Leptosittaca,"Lophochroa"=Lophochroa,"Loriculus"=Loriculus,"Lorius"=Lorius,"Mascarinus"=Mascarinus,"Melopsittacus"=Melopsittacus,"Micropsitta"=Micropsitta,"Myiopsitta"=Myiopsitta,"Nannopsittaca"=Nannopsittaca,"Neophema"=Neophema,"Neopsephotus"=Neopsephotus,"Neopsittacus"=Neopsittacus,"Nestor"=Nestor,"Northiella"=Northiella,"Nymphicus"=Nymphicus,"Oreopsittacus"=Oreopsittacus,"Orthopsittaca"=Orthopsittaca,"Parvipsitta"=Parvipsitta,"Passer"=Passer,"Pezoporus"=Pezoporus,"Phigys"=Phigys,"Pionites"=Pionites,"Pionopsitta"=Pionopsitta,"Pionus"=Pionus,"Platycercus"=Platycercus,"Poicephalus"=Poicephalus,"Polytelis"=Polytelis,"Primolius"=Primolius,"Prioniturus"=Prioniturus,"Probosciger"=Probosciger,"Prosopeia"=Prosopeia,"Psephotus"=Psephotus,"Pseudeos"=Pseudeos,"Psilopsiagon"=Psilopsiagon,"Psittacara"=Psittacara,"Psittacella"=Psittacella,"Psittacula"=Psittacula,"Psittaculirostris"=Psittaculirostris,"Psittacus"=Psittacus,"Psitteuteles"=Psitteuteles,"Psittinus"=Psittinus,"Psittrichas"=Psittrichas,"Purpureicephalus"=Purpureicephalus,"Pyrilia"=Pyrilia,"Pyrrhura"=Pyrrhura,"Rhynchopsitta"=Rhynchopsitta,"Strigops"=Strigops,"Tanygnathus"=Tanygnathus,"Thectocercus"=Thectocercus,"Touit"=Touit,"Trichoglossus"=Trichoglossus,"Triclaria"=Triclaria,"Tyrannus"=Tyrannus,"Vini"=Vini)
}

## TRIBE
{Amoropsittacini=c(Bolborhynchus,Nannopsittaca,Psilopsiagon,Touit)
 Androglossini=c(Alipiopsitta,Amazona,Brotogeris,Graydidascalus,Hapalopsittaca,Myiopsitta,Pionopsitta,Pionus,Pyrilia,Triclaria)
 
 Androglossini_A=c(Hapalopsittaca,Pyrilia,Triclaria)
 Androglossini_B=c(Brotogeris,Myiopsitta)
 Androglossini_C=c(Alipiopsitta,Amazona,Graydidascalus,Pionus)
 
 Arini=c(Deroptyus,Diopsittaca,Enicognathus,Eupsittula,Ognorhynchus,Guaruba,Leptosittaca,Orthopsittaca,Pionites,Primolius,Psittacara,Pyrrhura,Rhynchopsitta,Thectocercus)

 Arini_A=c(Deroptyus,Pionites)
 Arini_B=c(Pyrrhura)
 Arini_C=c(Anodorhynchus,Ara,Aratinga,Conuropsis,Cyanoliseus,Cyanopsitta,Diopsittaca,Enicognathus,Eupsittula,Ognorhynchus,Guaruba,Leptosittaca,Orthopsittaca,Primolius,Psittacara,Thectocercus)
 
 Cacatuini=c(Cacatua,Callocephalon,Eolophus,Lophochroa)
 Cyclopsittini=c(Cyclopsitta,Psittaculirostris)
 Forpini=c(Forpus)
 Loriini=c(Chalcopsitta,Charmosyna,Eos,Glossopsitta,Lorius,Neopsittacus,Oreopsittacus,Parvipsitta,Phigys,Pseudeos,Psitteuteles,Trichoglossus,Vini,Charminetta,Charmosynoides,Charmosynopsis,Glossoptilus,Hypocharmosyna,Synorhacma,Saudareos)
 Loriini_A=c(Charminetta,Charmosynoides,Charmosynopsis,Synorhacma,Charmosyna,Vini,Hypocharmosyna,Phigys)
 Loriini_B=c(Lorius,Neopsittacus,Parvipsitta,Pseudeos,Psitteuteles,Chalcopsitta,Glossoptilus,Saudareos,Eos,Glossopsitta,Trichoglossus)
 
 Melopsittacini=c(Melopsittacus)
 Microglossini=c(Probosciger)
 Micropsittini=c(Micropsitta)
 Pezoporini=c(Neophema,Neopsephotus,Pezoporus)
 Platycercini=c(Barnardius,Cyanoramphus,Eunymphicus,Lathamus,Northiella,Platycercus,Prosopeia,Psephotus,Purpureicephalus,Psephotellus)
 Polytelini=c(Alisterus,Aprosmictus,Polytelis)
 Psittaculini=c(Eclectus,Geoffroyus,Mascarinus,Prioniturus,Psittacula,Psittinus,Tanygnathus)
 #OUTGROUP=c(Acanthisitta,Falco,Passer,Tyrannus)
 OUTGROUP=c("Caracara_cheriway","Icterus_cucullatus","Calyptomena_viridis")

 tribes=list("Amoropsittacini"=Amoropsittacini,"Androglossini_A"=Androglossini_A,"Androglossini_B"=Androglossini_B,"Arini"=Arini,"Cacatuini"=Cacatuini,"Cyclopsittini"=Cyclopsittini,"Forpini"=Forpini,"Loriini"=Loriini,"Melopsittacini"=Melopsittacini,"Microglossini"=Microglossini,"Micropsittini"=Micropsittini,"Pezoporini"=Pezoporini,"Platycercini"=Platycercini,"Polytelini"=Polytelini,"Psittaculini"=Psittaculini,"OUTGROUP"=OUTGROUP)
}

## SUBFAM
{Agapornithinae=c(Agapornis,Bolbopsittacus,Loriculus)
 Arinae=c(Amoropsittacini,Androglossini,Arini,Forpini)
 Cacatuinae=c(Cacatuini,Microglossini)
 Calyptorhynchinae=c(Calyptorhynchus)
 Coracopseinae=c(Coracopsis)
 Loriinae=c(Cyclopsittini,Loriini,Melopsittacini)
 Nymphicinae=c(Nymphicus)
 Platycercinae=c(Pezoporini,Platycercini)
 Platycercinae_Pezoporini=c(Pezoporini)
 Platycercinae_Platyercini=c(Platycercini)
 Psittacellinae=c(Psittacella)
 Psittacinae=c(Poicephalus,Psittacus)
 Psittaculinae=c(Micropsittini,Polytelini,Psittaculini)
 Psittrichasinae=c(Psittrichas)
 subfams=list("Agapornithinae"=Agapornithinae,"Arinae"=Arinae,"Cacatuinae"=Cacatuinae,"Calyptorhynchinae"=Calyptorhynchinae,"Coracopseinae"=Coracopseinae,"Loriinae"=Loriinae,"Nymphicinae"=Nymphicinae,"Platycercinae_Pezoporini"=Platycercinae_Pezoporini,"Platycercinae_Platyercini"=Platycercinae_Platyercini,"Psittacellinae"=Psittacellinae,"Psittacinae"=Psittacinae,"Psittaculinae"=Psittaculinae,"Psittrichasinae"=Psittrichasinae,"OUTGROUP"=OUTGROUP)
}

## FAM
{Cacatuidae=c(Cacatuinae,Calyptorhynchinae,Nymphicinae)
 Nestoridae=c(Nestor)
 Psittacidae=c(Arinae,Psittacinae)
 Psittaculidae=c(Agapornithinae,Loriinae,Platycercinae,Psittacellinae,Psittaculinae)
 Psittrichasidae=c(Coracopseinae,Psittrichasinae)
 Strigopidae=c(Strigops)
 fams=list("Cacatuidae"=Cacatuidae,"Nestoridae"=Nestoridae,"Psittacidae"=Psittacidae,"Psittaculidae"=Psittaculidae,"Psittrichasidae"=Psittrichasidae,"Strigopidae"=Strigopidae,"OUTGROUP"=OUTGROUP)
}

## SUPERFAM
{Cacatuoidea=c(Cacatuidae)
 Psittacoidea=c(Psittacidae,Psittaculidae,Psittrichasidae)
 Strigopoidea=c(Nestoridae,Strigopidae)
 superfams=list("Cacatuoidea"=Cacatuoidea,"Psittacoidea"=Psittacoidea,"Strigopoidea"=Strigopoidea,"OUTGROUP"=OUTGROUP)
}

Passeriformes =c(Acanthisitta,Passer,Tyrannus)


root = root(input1,outgroup=OUTGROUP,resolve.root=T)
#plot.phylo(root,cex=0.3)

root$node.label = as.numeric(root$node.label)
root$node.label[1] = 100 
root$node.label[which(is.na(root$node.label))] = 100
rootblank = root
rootblank$node.label[rootblank$node.label==100] = "" 
rootblank$node.label[1] = ""
rootedTree = root

collapsed = root
badnodes = which(as.numeric(collapsed$node.label) < 50) + length(collapsed$tip.label) 
badnodes_indexes <- c()
for(node in badnodes){
 badnodes_indexes <- c(badnodes_indexes, which(collapsed$edge[,2] == node))
}
collapsed$edge.length[badnodes_indexes] = 0
collapsed = di2multi(collapsed)
collapsed$node.label = as.numeric(collapsed$node.label)



brewer = rev(brewer.pal(9,"YlOrRd"))
ramp = colorRampPalette(brewer)
cols = ramp(50)
names(cols) = seq(51,100)
plot(1:50,col=cols,pch=21,bg=cols)
labelcolors = cols[collapsed$node.label-50]

## FIGURE S1
## print the full large bootstrap tree, with low-support nodes collapsed
pdf("parrot_bootstrapCollapsedTree.pdf",
  width=15,height=40,pointsize=10)
plot.phylo(collapsed,no.margin=T,type="phylogram",align.tip.label = F,
      show.node.label = F,bg=labelcolors,cex=0.75)
nodelabels(collapsed$node.label,frame="n",cex=0.5,bg=labelcolors
      ,adj=c(1.2,-0.75))
nodelabels(pch=21,bg=labelcolors,cex=0.5)
add.scale.bar()
dev.off()



## FIGURE S2
## create multiple-panel PDF of subtrees 

lad = ladderize(midpoint.root(collapsed))

## create function to extract one species from each larger clade
makeSmallerTree = function(test,fams){
 onePer_fams = c()
 for(fam in fams){
  onePer_fams = c(onePer_fams,fam[1])
 }
 toDrop_fams = test$tip.label[!(test$tip.label %in% onePer_fams)]
 
 testd = (drop.tip(test, toDrop_fams))
 names(fams[testd$tip.label %in% fams])
 labels = c()
 for(tip in testd$tip.label){
  #print(tip)
  for(fam in names(fams)){
   #print(c("!!!!!",fam))
   column = which(names(fams)==fam)
   #print(column)
   #fams[[column]]
   if(tip %in% fams[[column]]){
    #print(c(tip,fam))
    labels = c(labels,fam)
   }
  }
 }
 testd$tip.label = labels
 return(testd)
}

## modify zoom function from APE package to draw custom bootstrap values 
zoom_custom <- function(phy, focus, subtree = FALSE, col = rainbow,scalebarlen=NULL,
            ...) {
 par(mfrow=c(1,1))
 if (!is.list(focus)) {
  focus <- list(focus)}
 n <- length(focus)
 for (i in 1:n) 
  if (is.character(focus[[i]])) {
   focus[[i]] <- which(phy$tip.label %in% focus[[i]]) # fix by Yan Wong 
  }
 if (is.function(col)) {
  col <- if (deparse(substitute(col)) == "grey") grey(1:n/n) else col(n)
 }
 ext <- vector("list", n)
 tips = c()
 for (i in 1:n) {
  ext[[i]] <- drop.tip(phy, phy$tip.label[-focus[[i]]],
             subtree = subtree, rooted = TRUE) 
  tips = c(tips,length(ext[[i]]$tip.label)+2)
 }
 
 #nc <- round(sqrt(n)) + 1
 #nr <- ceiling(sqrt(n))
 nr = n
 #nr = 1
 nc = 2
 M <- matrix(0, nr, nc)
 #print(M)
 x <- c(rep(1, nr), 2:(n + 1))
 M[1:length(x)] <- x
 #print(M);print(x);print(nc);print(nr);print(tips)
 layout(M, c(1, rep(3/(nc - 1), nc - 1))
     #,heights=log(tips))
     #,heights=(tips))
 )
 #layout.show()
 phy$tip.label <- rep("", length(phy$tip.label))
 colo <- rep("black", dim(phy$edge)[1])
 for (i in 1:n) {
  colo[which.edge(phy, focus[[i]])] <- col[i] }
 plot.phylo(phy, edge.color = colo, ...)
 for (i in 1:n) {
  ext[[i]]$node.nums = ext[[i]]$node.label
  ext[[i]]$node.asts = ext[[i]]$node.label
  
  ext[[i]]$node.nums[ext[[i]]$node.label=="Root"] = ""
  ext[[i]]$node.nums[ext[[i]]$node.label==100] = ""
  
  ext[[i]]$node.asts[ext[[i]]$node.label=="Root"] = "*"
  ext[[i]]$node.asts[ext[[i]]$node.label==100] = "*"
  ext[[i]]$node.asts[ext[[i]]$node.asts!="*"] = ""
  
  ext[[i]]$root.edge = 0.01
  #print(blank$node.label)
  plot.phylo(ext[[i]], edge.color = col[i],
        align.tip.label=F,
        #,tip.color=rgb(0,0,0,0),
        ...)
  #tiplabels(ext[[i]]$tip.label,cex=tipcex,frame="n",
  #     col="black")
  #nodelabels(ext[[i]]$node.asts,frame="n",adj=-0.25) 
 }
 nodelabels(ext[[i]]$node.nums,frame="n",adj=-0.25,
       cex=0.5)
 add.scale.bar(cex=0.5,length = scalebarlen)
}

{orders=list("Strigopoidea"=Strigopoidea,
       "Cacatuoidea"=Cacatuoidea,
       "Psittrichasidae"=Psittrichasidae,
       "Psittaculini"=Psittaculini,"Micropsittini"=Micropsittini,"Polytelini"=Polytelini,
       "Psittacellinae"=Psittacellinae,"Pezoporini"=Pezoporini,
       "Platycercini"=Platycercini,"Agapornithinae"=Agapornithinae,
       "Cyclopsittini"=Cyclopsittini,"Loriini_A"=Loriini_A,"Loriini_B"=Loriini_B,
       "Psittacinae"=Psittacinae,
       "Amoropsittacini"=Amoropsittacini,"Androglossini_A"=Androglossini_A,
       "Androglossini_B"=Androglossini_B,"Androglossini_C"=Androglossini_C,
       "Forpini"=Forpini,
       "Arini_A"=Arini_A,
       "Arini_B"=Arini_B,"Arini_C"=Arini_C)} 

## extract one species from each of the ordered taxa, replace species name with taxon name
testd = makeSmallerTree(lad,orders)

## create custom labels 
testd$node.nums = testd$node.label
testd$node.asts = testd$node.label
testd$node.nums[testd$node.label=="Root"] = ""
testd$node.nums[testd$node.label==100] = ""
testd$node.asts[testd$node.label=="Root"] = "*"
testd$node.asts[testd$node.label==100] = "*"
testd$node.asts[testd$node.asts!="*"] = ""

## make list of colors associated with each taxon for plotting purposes
{ordercol = c("brown","red",
       "magenta","cyan",
       "lightsteelblue","turquoise",
       "mediumpurple","seagreen",
       "lightseagreen","deepskyblue",
       "cadetblue","blue",
       "cornflowerblue","blueviolet",
       "dodgerblue","purple","pink","orange","lightgreen","darkcyan","grey","lightgrey","darkgrey","lightcyan")
}

## make list of cex values for each other 
## if cex is set too small, clades become too thin to discern topology
## if cex is set too big, clade names will not display properly

ordercex = c(0.9,0.65,## Strig, Caca
       0.9,0.6,     ## Psittrich, Psittacul
       0.7,0.65,  ## Pez, Psittacel
       0.8,0.7,  ## Platycer, Aga
       0.6,0.65,  ## Lor, Psittacin
       0.65,0.7,
       0.6,0.75,  ## Amor, AndroB
       0.6,0.65,
       0.75,0.65,  ## AndroA, Forp
       0.9,0.7,
       0.8,0.57)     ## Ari

scalebarlength=c(0.001,0.001,
                 0.001,0.001,
                 2e-4,2e-4,
                 2e-4,0.001,
                 0.001,0.001,
                 2e-4,2e-4,
                 2e-4,2e-4,
                 0.001,0.001,
                 0.001,0.001,
                 2e-4,2e-4,
                 2e-4,2e-4)

## print Figure S2
pdfstring = paste("figureS2_but_for_new_parrots.pdf",sep="")
pdf(pdfstring,width=10,height=12,pointsize=24)
for(i in 1:length(orders)){
  par(mar=c(0,0,0,1))
 print(i)
 tax = orders[[i]]
 #print(tax)
 nam = names(orders)[i]
 col = ordercol[i]
 cex = ordercex[i]
 scalebarlen = scalebarlength[i]
 #if(nam %in% c("Psittaculinae","Platycercini","Loriinae",
 #       "Androglossini_A","Arini")){ cex = 0.6 } 
 #else if (nam %in% c("Strigopoidea","Psittrichasidae")) { cex = 0.9 } ## 9 works ## 8 no
 #else if (nam %in% c("Psittaculidae")) { cex = 0.95 }
 #else { cex = 0.75 }
 zoom_custom(lad,focus=tax,col=col,subtree=F,no.margin=T,show.node.label=F,
       label.offset=0,edge.width=2,cex=cex,root.edge=F,use.edge.length=T,scalebarlen = scalebarlen)
}
dev.off()

