(*
 * Copyright (c) 2010 Thomas Gazagnaire <thomas@gazagnaire.org>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

open Types
open Html

(* People *)
let me = make_author "T. Gazagnaire" "http://gazagnaire.org"
let blaise = make_author "B. Genest" "www.crans.org/~genest"
let loic = make_author "L. Hélouët" "http://www.irisa.fr/distribcom/Personal_Pages/helouet/newloic.html"
let shaofa = make_author "S. Yang" "http://www.irisa.fr/distribcom/Personal_Pages/Shaofa/"
let thiagu = make_author "P.S. Thiagarajan" "http://www.comp.nus.edu.sg/~thiagu/"
let deb = make_author "D. Biswas" "http://www.linkedin.com/pub/1/526/397"
let claude = make_author "C. Jard" "http://www.dit.bretagne.ens-cachan.fr/People/Claude.Jard/"
    
let luc = make_author "L. Bougé" "http://www.dit.bretagne.ens-cachan.fr/People/Luc.Bouge/"
let francois = make_author "F. Bodin" "http://www.irisa.fr/caps/people/bodin/index.htm"

let richard = make_author "R. Sharp" "http://rich.recoil.org/"
let dave = make_author "D. Scott" "http://dave.recoil.org/"
let jonlud = make_author "J. Ludlam" "http://jon.recoil.org/index.xhtml"
let jondav = make_author "J. Davies" "http://www.cl.cam.ac.uk/~jjd27/"
let jsk = make_author "J. Knowles" "https://launchpad.net/~jsk"
let vincent = make_author "V. Hanquez" "http://tab.snarc.org/"
let marcus = make_author "M. Granado" "http://www.cl.cam.ac.uk/~mg376/"

let gerard = make_author "G. Boudol" "http://www-sop.inria.fr/members/Gerard.Boudol/"
let ilaria = make_author "I. Castellani" "http://www-sop.inria.fr/mimosa/personnel/Ilaria.Castellani.html"
let bruno = make_author "B. Arnaldi" "http://www.irisa.fr/bunraku/GENS/arnaldi/SOMMAIRE/Curiculum%20Vitae.html"

let stefano = make_author "S. Soatto" "http://www.cs.ucla.edu/~soatto/"
let paulo = make_author "P. Favaro" "http://www.eps.hw.ac.uk/~pf21/"
let hailin = make_author "H. Jin" "http://vision.ucla.edu/~hljin/"

let manuel = make_author "M. Serrano" "http://www-sop.inria.fr/members/Manuel.Serrano/"
let anil = make_author  "A. Madhavappeddy" "http://anil.recoil.org"
let mort = make_author "R. Mortier" "http://www.cs.nott.ac.uk/~rmm/"
let rip = make_author "R. Sohan" "http://www.cl.cam.ac.uk/~rss39/"
let hand = make_author "S. Hand" "http://www.cl.cam.ac.uk/~smh22/"
let tim = make_author "T. Deegan" "http://www.tjd.phlegethon.org/"
let derek = make_author "D. McAuley" "http://www.cs.nott.ac.uk/~drm/"
let crowcroft = make_author "J. Crowcroft" "http://www.cl.cam.ac.uk/~jac22/"

let p_weis = make_author "P. Weis" "http://pauillac.inria.fr/~weis/"

let map_link (t,l) =  { text="["^t^"]"; href=l }

module Publis = struct
 
  let refereed = ref []
  let tech = ref []

  type kind = Refereed | Tech

  let save_custom y k a t w f =
    let p = {
      authors = a;
      title   = t;
      where   = w;
      year    = y;
      files   = List.map map_link f;
    } in
    match k with
      | Refereed -> refereed := p :: !refereed
      | Tech     -> tech     := p :: !tech 

  let save y k a t w =
    save_custom y k a t w
      [ "pdf", Printf.sprintf "pub/%s.pdf" (short_name a y) ]

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
    current := { name = n; description = d; links = List.map map_link l } :: !current
  
  let save_past n d l =
    past := { name = n; description = d; links = List.map map_link l } :: !past

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
      An ML-to-Scheme compiler, initially written by $html_of_author manuel$
      and $html_of_author p_weis$ few decades ago.>>
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
      <em>Dyntype</em> is a Camlp4 extension adding dynamic types to OCaml.
      <em>ORM</em> uses dynamic types to provide a complete and efficient
        Object-Relationship Mapping to SQlite3 for OCaml.
      <em>Shelf</em> uses dynamic types to provide a collection
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

let dblp = <:html<<a href ="http://www.informatik.uni-trier.de/~ley/db/indices/a-tree/g/Gazagnaire:Thomas.html">DBLP</a>&>>
let inria_sop = <:html<<a href="http://www-sop.inria.fr">INRIA sophia-antipolis</a>&>>
let indes = <:html<<a href="http://www-sop.inria.fr/indes/">INDES</a>&>>
let irisa = <:html<<a href="http://www.irisa.fr/">IRISA</a>&>>
let distribcom = <:html<<a href="http://www.irisa.fr/distribcom/">DistribCom</a>&>>
let citrix = <:html<<a href="http://www.citrix.com">Citrix</a>&>>
let xenserver = <:html<<a href="www.citrix.com/xenserver">XenServer</a>&>>
let xcp = <:html<<a href="http://www.xen.org/products/cloudxen.html">Xen Cloud Platform</a>&>>
let ocaml = <:html<<a href="http://caml.inria.fr/ocaml/index.en.html">OCaml</a>&>>
let github = <:html<<a href="http://www.github.com/samoht">github</a>&>>
let ens_lyon = <:html<<a href="http://www.ens-lyon.eu">ENS Lyon</a>&>>
let ens_cachan = <:html<<a href="http://www.bretagne.ens-cachan.fr">ENS Cachan-Bretagne</a>&>>

let htcaml = <:html<<a href="http://www.github.com/samoht/htcaml">HTCaML</a>&>>
let cass = <:html<<a href="http://www.github.com/samoht/cass">CaSS</a>&>>
