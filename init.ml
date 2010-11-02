open Base

(* People *)

let make name link = { name=name; link=link }

let me = make "T. Gazagnaire" "http://gazagnaire.org"
let blaise = make "B. Genest" "www.crans.org/~genest"
let loic = make "L. Hélouët" "http://www.irisa.fr/distribcom/Personal_Pages/helouet/newloic.html"
let shaofa = make "S. Yang" "http://www.irisa.fr/distribcom/Personal_Pages/Shaofa/"
let thiagu = make "P.S. Thiagarajan" "http://www.comp.nus.edu.sg/~thiagu/"
let deb = make "D. Biswas" "http://www.linkedin.com/pub/1/526/397"
let claude = make "C. Jard" "http://www.dit.bretagne.ens-cachan.fr/People/Claude.Jard/"
    
let luc = make "L. Bougé" "http://www.dit.bretagne.ens-cachan.fr/People/Luc.Bouge/"
let francois = make "F. Bodin" "http://www.irisa.fr/caps/people/bodin/index.htm"

let richard = make "R. Sharp" "http://rich.recoil.org/"
let dave = make "D. Scott" "http://dave.recoil.org/"
let jonlud = make "J. Ludlam" "http://jon.recoil.org/index.xhtml"
let jondav = make "J. Davies" "http://www.cl.cam.ac.uk/~jjd27/"
let jsk = make "J. Knowles" "https://launchpad.net/~jsk"
let vincent = make "V. Hanquez" "http://tab.snarc.org/"
let marcus = make "M. Granado" "http://www.cl.cam.ac.uk/~mg376/"

let gerard = make "G. Boudol" "http://www-sop.inria.fr/members/Gerard.Boudol/"
let ilaria = make "I. Castellani" "http://www-sop.inria.fr/mimosa/personnel/Ilaria.Castellani.html"
let bruno = make "B. Arnaldi" "http://www.irisa.fr/bunraku/GENS/arnaldi/SOMMAIRE/Curiculum%20Vitae.html"

let stefano = make "S. Soatto" "http://www.cs.ucla.edu/~soatto/"
let paulo = make "P. Favaro" "http://www.eps.hw.ac.uk/~pf21/"
let hailin = make "H. Jin" "http://vision.ucla.edu/~hljin/"

let manuel = make "M. Serrano" "http://www-sop.inria.fr/members/Manuel.Serrano/"
let anil = make  "A. Madhavappeddy" "http://anil.recoil.org"
let mort = make "R. Mortier" "http://www.cs.nott.ac.uk/~rmm/"
let rip = make "R. Sohan" "http://www.cl.cam.ac.uk/~rss39/"
let hand = make "S. Hand" "http://www.cl.cam.ac.uk/~smh22/"
let tim = make "T. Deegan" "http://www.tjd.phlegethon.org/"
let derek = make "D. McAuley" "http://www.cs.nott.ac.uk/~drm/"
let crowcroft = make "J. Crowcroft" "http://www.cl.cam.ac.uk/~jac22/"

module Publis = struct
 
  let refereed = ref []
  let tech = ref []

	let save_custom y k a t w f =
    let p = {
      authors=a;
		  title=t;
		  where=w;
		  year=y;
		  kind=k;
		  files=f;
    } in
    match k with
      | Refereed -> refereed := p :: !refereed
      | Tech     -> tech     := p :: !tech 

	let save y k a t w =
    save_custom y k a t w ["pdf", Printf.sprintf "pub/%s.pdf" (short_name a y)]

	let causaux = "Causal Message Sequence Charts"

	let () =
    save
      2010
		  Refereed
      [dave; richard; me; anil]
      "Using Functional Programming within an Industrial Product Group: Perspectives and Perceptions"
      "The 15th ACM SIGPLAN International Conference on Functional Programming";

    save
		  2010
      Refereed
      [anil; mort; rip; me; hand; tim; derek; crowcroft]
      "Turning down the LAMP: Software Specialisation for the Cloud"
      "The 2nd USENIX Workshop on Hot Topics in Cloud Computing";

    save
      2010
		  Refereed
      [me; anil]
      "Statically-typed value persistence for ML"
      "The 1st Workshop on Generative Technologies";
    
	  save
      2009
		  Refereed
      [me; vincent]
      "OXenstored: an efficient hierarchical and transactional database using functional programming with reference cell comparisons"
      "The 14th ACM SIGPLAN International Conference on Functional Programming";

    save
      2009
		  Refereed
      [me; blaise; loic; thiagu; shaofa]
      causaux
      "Theoretical Computer Science, Volume 410, Number 41";

    save_custom
      2008
		  Tech 
      [me]
      "Projection of Rational Pomset Expression"
      "Draft"
      ["pdf", "Gazagnaire08-draft.pdf"];

    save
      2008
		  Refereed
      [shaofa; loic; me]
      "Logic-based Diagnosis for Distributed Systems"
		  "'Perspectives in Concurrency -- Feststichrift for P.S. Thiagarajan'. World Scientific";

		save
      2008
      Refereed
      [deb; me; blaise]
      "Small Logs for Transactional Services: Distinction is much more accurate than (Positive) Discrimination"
      "The 11th IEEE High Assurance Systems Engineering Symposium";

		save_custom
      2008
      Tech
      [me]
      "Langages de Scénarios: Utiliser des Ordres Partiels pour Modéliser, Vérifier et Superviser des Systèmes Parallèles et Répartis"
		  "Ph.D. Thesis, University of Rennes 1"
      ["pdf"   , "pub/gazagnaire-phd.pdf";
       "slides", "pub/gazagnaire-phd-slides.pdf";
       "book" , "http://www.amazon.fr/Langages-Scnarios-Thomas-Gazagnaire/dp/6131513082"];

	  save 
      2007
		  Refereed
      [me; blaise; loic; thiagu; shaofa]
      causaux
      "The 18th International Conference on Concurrency Theory";

    save
      2007
      Refereed
      [me; loic]
      "Reconstructing Causal Ordering with boxed pomsets"
      "The 27th IFIP WG 6.1 International Conference on Formal Methods for Networked and Distributed Systems";

    save
      2007
      Refereed
      [me; claude]
      "Abstraire à la Volée les Evénements d'un Système Réparti"
      "La 7 ème Conférence Internationale sur les NOuvelles TEchnologies de la REpartition";
    
    save_custom
      2007
      Tech
      [me; shaofa; loic; blaise; thiagu]
      causaux
      "Research Report RR-6301"
      ["pdf", "pub/RR-6301.pdf"];
    
    save
      2006
		  Refereed
      [loic; me; blaise]
      "Diagnosis from Scenarios"
      "The 8th International Workshop on Discrete Event Systems";
    
		save_custom
      2005
      Tech
      [me; loic; claude] 
			"Online Abstraction of Distributed Executions"
      "Research Report RR-5736"
      ["pdf", "pub/RR-5736.pdf"];

end

let refereed_publications = List.rev !Publis.refereed
let tech_publications     = List.rev !Publis.tech

module Projects = struct
  let current = ref []
  let past = ref []

  let save n d l =
    current := { p_name = n; p_description = d; p_links = l } :: !current
  
  let save_past n d l =
    past := { p_name = n; p_description = d; p_links = l } :: !past

  let () =
    save
      "mirage"
      <:html<
      An open-source operating system for constructing secure,
      high-performance, reliable network applications across a
      variety of cloud computing and mobile platforms.>>
      [ "website"   , "http://www.openmirage.org";
        "paper"     , "pub/SSGM10.pdf";
        "mirage.git", "http://www.github.com/avsm/mirage" ];

    save
      "camloo"
      <:html<
      An ML-to-Scheme compiler, initially written by <a href=$str:manuel.link$>
      $str:manuel.name$</> and <a href="http://pauillac.inria.fr/~weis/">
      Pierre Weis</> few decades ago.>>
      [ "website"   , "http://www-sop.inria.fr/members/Thomas.Gazagnaire/";
        "camloo.git", "http://www.github.com/samoht/camloo" ];

    save
      "HTCaML / CaSS"
      <:html<
      Camlp4 syntax extensions to write static HTML and CSS files directly
      in OCaml. These tools have been used to write the page you are reading.>>
      [ "HTCaML.git", "http://www.github.com/samoht/htcaml";
        "CaSS.git"  , "http://www.github.com/samoht/cass"; ];

    save
      "dyntype / ORM / Shelf"
      <:html<
      A collection of tools using dynamic types in OCaml.
      <em>Dyntype</> is a Camlp4 extension adding dynamic types to OCaml.
      <em>ORM</> uses dynamic types to provide a complete and efficient
        Object-Relationship Mapping to SQlite3 for OCaml.
      <em>Shelf</> uses dynamic types to provide a collection
        of parsers and printers to JSON, S-expressions, HTML, ... >>
      [ "paper"      , "pub/GM10.pdf";
        "dyntype.git", "http://www.github.com/mirage/dyntype";
        "ORM.git"    , "http://www.github.com/mirage/orm";
        "Shelf.git"  , "http://www.github.com/mirage/shelf" ];

    save_past
      "Xen Cloud Platform"
      <:html<
      Xen Cloud Platform offers ISVs and service providers a complete
      cloud infrastructure platform with a powerful management stack
      based on open, standards-based APIs, support for mutli-tenancy,
      SLA guarantees and deteailed metrics for consumption based charging.
      >>
      [ "website"    , "http://www.xen.org/products/cloudxen.html";
        "xen-org.git", "http://github.com/xen-org" ];

    save_past
      "DistriL / Scenario Doctor / ADEx"
      <:html< A set of tools that I developped during my Ph.D thesis. >>
      [ "DistriL.tgz", "tools/DistriL.tar.gz";
        "SD.tgz"     , "tools/ScenarioDoctor.tar.gz";
        "aDEx.tgz"   , "tools/ADEx.tar.gz" ]

      
end

let current_projects = List.rev !Projects.current
let past_projects = List.rev !Projects.past
