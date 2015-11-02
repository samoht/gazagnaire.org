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
open Cow.Html

(* People *)
let me = make_author "T. Gazagnaire" "http://gazagnaire.org"
let blaise = make_author "B. Genest" "www.crans.org/~genest"
let loic = make_author "L. Hélouët" "http://www.irisa.fr/distribcom/Personal_Pages/helouet/newloic.html"
let shaofa = make_author "S. Yang" "http://www.irisa.fr/distribcom/Personal_Pages/Shaofa/"
let thiagu = make_author "P.S. Thiagarajan" "http://www.comp.nus.edu.sg/~thiagu/"
let deb = make_author "D. Biswas" "http://www.linkedin.com/pub/1/526/397"
let claude = make_author "C. Jard" "http://www.dit.bretagne.ens-cachan.fr/People/Claude.Jard/"
let herve = make_author "H. Marchand" "http://www.irisa.fr/prive/hmarchan/"

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
let anil = make_author  "A. Madhavapeddy" "http://anil.recoil.org"
let mort = make_author "R. Mortier" "http://www.cs.nott.ac.uk/~rmm/"
let rip = make_author "R. Sohan" "http://www.cl.cam.ac.uk/~rss39/"
let hand = make_author "S. Hand" "http://www.cl.cam.ac.uk/~smh22/"
let tim = make_author "T. Deegan" "http://www.tjd.phlegethon.org/"
let derek = make_author "D. McAuley" "http://www.cs.nott.ac.uk/~drm/"
let crowcroft = make_author "J. Crowcroft" "http://www.cl.cam.ac.uk/~jac22/"
let leslie = make_author "I. Leslie" "https://www.cl.cam.ac.uk/~iml1/"
let rostos = make_author "C. Rotsos" "http://www.cl.cam.ac.uk/~cr409/"
let balraj = make_author "B. Singh" "#"
let smith = make_author "S. Smith" "#"
let amir = make_author "A. Chaudhry" "http://amirchaudhry.com/"
let dimino = make_author "J. Dimino" "https://github.com/diml"

let p_weis = make_author "P. Weis" "http://pauillac.inria.fr/~weis/"

let cagdas = make_author "Ç. Bozman" "http://cagdas.bozman.fr"
let fabrice = make_author "F. Le Fessant" "http://fabrice.lefessant.net/"
let michel = make_author "M. Mauny" "http://www.mauny.net/index.en.php"
let louis = make_author "L. Gesbert" "http://louis.gesbert.fr/cv.en.html"
let leonard = make_author "T. Leonard" "http://roscidus.com/blog/"
let magnus = make_author "M. Skjegstad" "http://www.skjegstad.com/"
let mindy = make_author "M. Preston" "http://www.somerandomidiot.com/"
let sheets = make_author "D. Sheets" "https://github.com/dsheets"
let shinwell = make_author "M. Shinwell" "http://www.three-tuns.net/mark"
let leo = make_author "L. White" "https://github.com/lpw25"
let jeremy = make_author "J. Yallop" "https://github.com/yallop"
let gregory = make_author "G. Tsipenyuk" "#"
let wang = make_author "P. Wang" "http://philippewang.info/"

let farinier = make_author "B. Farinier" "#"

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

  let causaux = "Causal Message Sequence Charts."

  let () =

    save_custom
      2015
      Refereed
      [anil;amir;me;jeremy;sheets]
      "The State of the OCaml Platform."
      "OCaml Workshop 2015" [];

    save_custom
      2015
      Refereed
      [mindy;magnus;me;mort;anil]
      "Persistent Networking with Irmin and MirageOS"
      "OCaml Workskop 2015" [];

    save
      2015
      Refereed
      [anil;leonard;magnus;me;sheets;dave;mort;amir;balraj;jonlud;crowcroft;leslie]
      "Jitsu: Just-In-Time Summoning of Unikernels"
      "12th USENIX Symposium on Networked Systems Design and Implementation (NSDI 15).";

    save
      2015
      Refereed
      [farinier; me; anil]
      "Mergeable Persistent Data Structures"
      "Les vingt-sixième Journées Francophones des Langages Applicatifs.";

    save_custom
      2014
      Refereed
      [loic; herve; blaise; me]
      "Diagnosis from Scenarios."
      "Journal of Discrete Event Dynamic Systems. Volume 24, Issue 4 , pp 353-415."
      [];

    save_custom
      2014
      Refereed
      [anil; me; dave; mort]
      "Metaprogramming with ML modules in the MirageOS."
      "ML Family Workshop."
      ["pdf", "https://sites.google.com/site/mlworkshoppe/Gazagnaire-abstract.pdf"];

    save_custom
      2014
      Refereed
      [anil; amir; dimino; me; louis; leonard; sheets; shinwell; leo; jeremy]
      "The OCaml Platform v1.0."
      "The OCaml User and Developper Workshop."
      ["pdf", "https://ocaml.org/meetings/ocaml/2014/ocaml2014_7.pdf"];

    save_custom
      2014
      Refereed
      [me; amir; anil; mort; dave; sheets; gregory; crowcroft]
      "Irmin: a branch-consistent distributed library database."
      "The OCaml User and Developper Workshop."
      ["pdf", "https://ocaml.org/meetings/ocaml/2014/ocaml2014_11.pdf"];

    save_custom
      2013
      Refereed
      [anil; mort; rostos; dave; balraj; me; smith; hand; crowcroft]
      "Unikernels: Library Operating Systems for the Cloud."
      "The 18th International Conference on Architectural Support for Programming Languages \
       and Operating Systems (ASPLOS 2013)."
      ["pdf", "http://anil.recoil.org/papers/2013-asplos-mirage.pdf"];

    save_custom
      2013
      Refereed
      [anil; amir; me; sheets; wang; leo; jeremy]
      "The OCaml Platform v0.1."
      "The OCaml User and Developper Workshop."
      ["pdf", "http://ocaml.org/meetings/ocaml/2013/proposals/platform.pdf"];

    save_custom
      2013
      Refereed
      [sheets; anil; amir; me]
      "Ocamlot: OCaml Online Testing."
      "The OCaml User and Developper Workshop."
      ["pdf", "http://ocaml.org/meetings/ocaml/2013/proposals/ocamlot.pdf"];

    save_custom
      2013
      Refereed
      [cagdas; michel; fabrice; me]
      "Profiling the Memory Usage of OCaml Applications without Changing their Behavior."
      "The OCaml User and Developper Workshop."
      ["pdf", "http://ocaml.org/meetings/ocaml/2013/proposals/profiling-memory.pdf"];

    save_custom
      2012
      Refereed
      [me]
      "OPAM, a package manager for OCaml."
      "The OCaml User and Developper Workshop."
      ["slides", "http://oud.ocaml.org/2012/slides/oud2012-paper17-slides.pdf";
       "video" , "http://www.youtube.com/watch?v=ivLqeRZJTGs&feature=plcp" ];

    save_custom
      2012
      Refereed
      [cagdas; me; fabrice; michel]
      "Study of OCaml programs' memory behavior."
      "The OCaml User and Developper Workshop."
      [];

    save_custom
      2012
      Refereed
      [fabrice; me]
      "Gestion de projet avec ocp-build."
      "Les vingt troisièmes Journées Francophones des Langages Applicatifs."
      ["pdf", "http://hal.inria.fr/docs/00/66/59/62/PDF/paper_10.pdf"];

    save
      2011
      Refereed
      [me; anil]
      "Dynamics for ML using Meta-Programming."
      "Electronic Notes in Theoretical Computer Science (ENTCS).";

    save_custom
      2010
      Refereed
      [anil; me]
      "Mirage: ML kernels in the Cloud."
      "ML Family Workshop."
      ["slides", "http://www.slideshare.net/AnilMadhavapeddy/mirage-ml-kernels-in-the-\
                  cloud-ml-workshop-2010"];

    save
      2010
      Refereed
      [dave; richard; me; anil]
      "Using Functional Programming within an Industrial Product Group: Perspectives \
       and Perceptions."
      "The 15th ACM SIGPLAN International Conference on Functional Programming.";

    save
      2010
      Refereed
      [anil; mort; rip; me; hand; tim; derek; crowcroft]
      "Turning down the LAMP: Software Specialisation for the Cloud."
      "The 2nd USENIX Workshop on Hot Topics in Cloud Computing.";

    save
      2010
      Refereed
      [me; anil]
      "Statically-typed value persistence for ML."
      "The 1st Workshop on Generative Technologies.";

    save
      2009
      Refereed
      [me; vincent]
      "OXenstored: an efficient hierarchical and transactional database using functional \
       programming with reference cell comparisons."
      "The 14th ACM SIGPLAN International Conference on Functional Programming.";

    save
      2009
      Refereed
      [me; blaise; loic; thiagu; shaofa]
      causaux
      "Theoretical Computer Science, Volume 410, Number 41.";

    save_custom
      2008
      Tech
      [me]
      "Projection of Rational Pomset Expression."
      "Draft."
      ["pdf", "pub/Gazagnaire08-draft.pdf"];

    save
      2008
      Refereed
      [shaofa; loic; me]
      "Logic-based Diagnosis for Distributed Systems."
      "'Perspectives in Concurrency -- Feststichrift for P.S. Thiagarajan'. World Scientific.";

    save
      2008
      Refereed
      [deb; me; blaise]
      "Small Logs for Transactional Services: Distinction is much more accurate than \
       (Positive) Discrimination."
      "The 11th IEEE High Assurance Systems Engineering Symposium.";

    save_custom
      2008
      Tech
      [me]
      "Langages de Scénarios: Utiliser des Ordres Partiels pour Modéliser, Vérifier et \
       Superviser des Systèmes Parallèles et Répartis."
      "Ph.D. Thesis, University of Rennes 1."
      ["pdf"   , "pub/gazagnaire-phd.pdf";
       "slides", "pub/gazagnaire-phd-slides.pdf";
       "book" , "http://www.amazon.fr/Langages-Scnarios-Thomas-Gazagnaire/dp/6131513082"];

    save
      2007
      Refereed
      [me; blaise; loic; thiagu; shaofa]
      causaux
      "The 18th International Conference on Concurrency Theory.";

    save
      2007
      Refereed
      [me; loic]
      "Reconstructing Causal Ordering with boxed pomsets."
      "The 27th IFIP WG 6.1 International Conference on Formal Methods for Networked \
       and Distributed Systems.";

    save
      2007
      Refereed
      [me; claude]
      "Abstraire à la Volée les Evénements d'un Système Réparti"
      "La 7 ème Conférence Internationale sur les NOuvelles TEchnologies de la REpartition.";

    save_custom
      2007
      Tech
      [me; shaofa; loic; blaise; thiagu]
      causaux
      "Research Report RR-6301."
      ["pdf", "pub/RR-6301.pdf"];

    save
      2006
      Refereed
      [loic; me; blaise]
      "Diagnosis from Scenarios."
      "The 8th International Workshop on Discrete Event Systems.";

    save_custom
      2005
      Tech
      [me; loic; claude]
      "Online Abstraction of Distributed Executions."
      "Research Report RR-5736."
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
      "Mirage"
      <:html<
         Mirage OS is a library operating system that constructs unikernels for
         secure, high-performance network applications across a variety of cloud
         computing and mobile platforms. Code can be developed on a normal OS
         such as Linux or MacOS X, and then compiled into a fully-standalone,
         specialised unikernel that runs under the Xen hypervisor. >>
      [ "website"   , "http://www.openmirage.org";
        "paper"     , "http://anil.recoil.org/papers/2013-asplos-mirage.pdf";
        "mirage.git", "http://www.github.com/mirage" ];

    save
      "Irmin"
      <:html<
        Irmin is a library database that takes the principles behind tools like
        Git and applies them to the wider problem of storing and syncing our
        data. This allows the possibility for all software using the Irmin layer
        to remain in sync as changes can be pushed directly from one location to
        another. It also allows the possibility of reverting to previous
        versions of any content as all history is also preserved.
      >>
      [ "intro"    , "http://openmirage.org/blog/introducing-irmin";
        "irmin.git", "http://www.github.com/mirage" ];

    save
      "OPAM"
      <:html<
      OPAM is a source-based package manager for OCaml. It supports multiple simultaneous
      compiler installations, flexible package constraints, and a Git-friendly development
      workflow. It is the default package manager when using OCaml.
      >>
      [ "website" , "http://opam.ocaml.org";
        "opam.git", "http://www.github.com/ocaml/opam" ];

    save_past
      "Xen API"
      <:html<
        Xen API (or xapi) is a management stack that configures and
        controls Xen-enabled hosts and resource pools, and co-ordinates
        resources within the pool. Xapi exposes the Xen API interface
        for many languages and is a component of Citrix XenServer.
        Xen API is written mostly in <a href="http://ocaml.org">OCaml</a>.
      >>
      [ "website"         , "http://xenproject.org/developers/teams/xapi.html";
        "xapi-project.git", "http://github.com/xapi-project" ];

    save_past
      "camloo"
      <:html<
      An ML-to-Scheme compiler, initially written by $html_of_author manuel$
      and $html_of_author p_weis$ few decades ago.>>
      [ "website"   , "http://www-sop.inria.fr/members/Thomas.Gazagnaire/";
        "camloo.git", "http://www.github.com/samoht/camloo" ];

    save_past
      "DistriL / Scenario Doctor / ADEx"
      <:html<
      A set of tools that I developped during my Ph.D thesis, to deal
      with diagnostic and monitoring of distributed systems.>>
      [ "DistriL.tgz", "tools/DistriL.tar.gz";
        "SD.tgz"     , "tools/ScenarioDoctor.tar.gz";
        "aDEx.tgz"   , "tools/ADEx.tar.gz" ]


end

let current_projects = List.rev !Projects.current
let past_projects = List.rev !Projects.past

let dblp = <:html<<a href ="http://www.informatik.uni-trier.de/~ley/db/indices/a-tree/g/Gazagnaire:Thomas.html">DBLP</a>&>>
let inria_sop = <:html<<a href="http://www-sop.inria.fr/">INRIA sophia-antipolis</a>&>>
let indes = <:html<<a href="http://www-sop.inria.fr/indes/">INDES</a>&>>
let irisa = <:html<<a href="http://www.irisa.fr/">IRISA</a>&>>
let distribcom = <:html<<a href="http://www.irisa.fr/distribcom/">DistribCom</a>&>>
let citrix = <:html<<a href="http://www.citrix.com/">Citrix</a>&>>
let xenserver = <:html<<a href="http://www.citrix.com/xenserver">XenServer</a>&>>
let ocaml = <:html<<a href="http://ocaml.org/">OCaml</a>&>>
let github = <:html<<a href="http://www.github.com/samoht/">Github</a>&>>
let ens_lyon = <:html<<a href="http://www.ens-lyon.eu/">ENS Lyon</a>&>>
let ens_cachan = <:html<<a href="http://www.ens-rennes.fr">ENS Rennes</a>&>>
let ocamlpro = <:html<<a href="http://www.ocamlpro.com/">OCamlPro</a>&>>
let computer_lab = <:html<<a href="http://cl.cam.ac.uk">University of Cambridge</a>&>>
let unikernel = <:html<<a href="http://unikernel.com">Unikernel Systems</a>&>>
let onapp = <:html<<a href="http://onapp.com/">OnApp</a>&>>
let opam = <:html<<a href="http://opam.ocamlpro.com/">OPAM</a>&>>
let cow = <:html<<a href="http://www.github.com/mirage/ocaml-cow">CoW</a>&>>
let mirage = <:html<<a href="http://www.openmirage.org/">Mirage</a>&>>
let irmin = <:html<<a href="https://github.com/mirage/irmin">Irmin</a>&>>
