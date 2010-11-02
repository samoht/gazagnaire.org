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

open Base

(* People *)
let html_of_people t =
  <:html< <a href=$str:t.link$ class="people"> $str:t.name$ </> >>

(* Publications *)
let html_of_links (name, link) =
  <:html<
    <a href=$str:link$>$str:"["^name^"]"$</>
  >>

let html_of_publication p =
  let cl =
    Printf.sprintf "\"publication %s\""
      (match p.kind with Tech -> "tech" | Refereed -> "refereed") in
  <:html<
    <div class=$str:cl$ id=$str:short_name p.authors p.year$>
      <div class="title">$str:p.title$</>
      <div class="authors">$list:List.map html_of_people p.authors$</>
      <div class="descr">
        <span class="where">$str:p.where ^ ","$</>
        <span class="when">$str:string_of_int p.year ^ "."$</>
        <span class="files">$list:List.map html_of_links p.files$</>
      </>
    </>
  >>

let papers =
  <:html<
    <div class="left">
    <h1>Refereed publications</>
    $list:List.map html_of_publication Init.refereed_publications$
    </>
    <div class="right">
    <p>My <a href="http://www.informatik.uni-trier.de/~ley/db/indices/a-tree/g/Gazagnaire:Thomas.html">DBLP page</> lists some of my publications.</>
    <h1>Tech reports</>
    $list:List.map html_of_publication Init.tech_publications$
    </>
  >>

(* Projects *)
let html_of_project p =
  <:html< 
    <div class="project">
      <div class="name">$str:p.p_name$</>
      <div class="description">$p.p_description$</>
      <div class="links">$list:List.map html_of_links p.p_links$</>
    </>
  >>

let projects =
  <:html<
    <div class="left current">
      <h1>Current projects</>
      $list:List.map html_of_project Init.current_projects$
    </>
    <div class="right past">
      <h1>Past projects</>
      $list:List.map html_of_project Init.past_projects$
    </>
  >>

(* Home page *)
let inria_sop = <:html< <a href="http://www-sop.inria.fr">INRIA sophia-antipolis</> >>
let indes = <:html< <a href="http://www-sop.inria.fr/indes/">INDES</> >>
let irisa = <:html< <a href="http://www.irisa.fr/">IRISA</> >>
let distribcom = <:html< <a href="http://www.irisa.fr/distribcom/">DistribCom</> >>
let citrix = <:html< <a href="http://www.citrix.com">Citrix</> >>
let xenserver = <:html< <a href="www.citrix.com/xenserver">XenServer</> >>
let xcp = <:html< <a href="http://www.xen.org/products/cloudxen.html">Xen Cloud Platform</> >>
let ocaml = <:html< <a href="http://caml.inria.fr/ocaml/index.en.html">OCaml</> >>
let github = <:html< <a href="http://www.github.com/samoht">github</> >>
let ens_lyon = <:html< <a href="http://www.ens-lyon.eu">ENS Lyon</> >>
let ens_cachan = <:html< <a href="http://www.bretagne.ens-cachan.fr">ENS Cachan-Bretagne</> >>

let home =
	<:html<
    <div class="left">
    <h1>Thomas Gazagnaire</>
    <p>I am a postdoctoral fellow at $inria_sop$, in the $indes$ project.
    Previously, I have been working in $citrix$ on $xenserver$ and $xcp$
    as a senior software engineer.
    I completed my Ph.D in 2008 at $irisa$ in the $distribcom$ project.
    I obtained my Master and Bachelor degrees from $ens_lyon$ and $ens_cachan$.</>

    <p>My research interests primarily involve the application of formal methods and
    functional programming languages to complex-system engineering problems. More generally,
    I have a wide range of research and application interests including:</>
		<ul>
      <li>Cloud-computing;</>
		  <li>Distributed and concurrent systems;</>
			<li>Verification (model-checking) of complex systems;</>
			<li>Automatic fault-diagnosis and monitoring of complex systems;</>
			<li>Application of functional programming to real-world problems;</>
			<li>Compilation and optimization techniques;</>
			<li>Partial-order theory.</>
    </>
    <p>I am doing most of my software developments in $ocaml$. My projects
    are on hosted $github$.</>
    </>

    <div class="right image"><img src="thomas.png"/></>
	>>

(* Main *)
let string_of_time () =
	let t = Unix.localtime (Unix.time ()) in
	Printf.sprintf "%d/%d/%d" t.Unix.tm_mday (t.Unix.tm_mon + 1) (t.Unix.tm_year + 1900)

let create ~title ~header ~body ~footer =
  <:html<
  <html>
    <head>
      <meta http-equiv='Content-type' content='text/html; charset=UTF-8'/>
	    <title>Thomas Gazagnaire :: $str:title$</>
	    <link rel='stylesheet' href='style.css' type='text/css' media='all'/>
    </>
    <body>
      <div class="header">$header$</>
      <div class="body">$body$</>
      <div class="footer">$footer$</>
    </>
  </>
  >>

let make_nav pages =
  let one (n,l,_) = <:html< <li><a href=$str:l$>$str:n$</></> >> in
  let inter = <:html< <li>::</> >> in
  let rec aux = function
    | []   -> []
    | [h]  -> [one h]
    | h::t -> (one h) :: inter :: aux t in
  <:html<
    <div class="nav"><ul>$list:aux pages$</></>
  >>

let process pages =
  let footer = <:html<
      &copy; 2010 Thomas Gazagnaire ::
      Last modified : $str:string_of_time ()$ ::
      Generated by <a href="http://www.github.com/samoht/htcaml">HTCaML</>
      and <a href="http://www.github.com/samoht/cass">CaSS</>.
    >> in
  let header = make_nav pages in
  let aux (name, link, contents) =
    let chan = open_out ("www/" ^ link) in
    let page = create ~title:name ~header ~body:contents ~footer in
    output_string chan (Html.to_string page);
    close_out chan 
in
  List.iter aux pages

let () =
  Printf.printf "Generating index.html and papers.html... %!";
  process [
    "home", "index.html", home;
    "papers", "papers.html", papers;
    "projects", "projects.html", projects;
  ];
  Printf.printf "[Done]\n"
