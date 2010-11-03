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
open Data
open Html

(* People *)
let papers = {
  left = <:html<
    <h1>Refereed publications</>
    $list:List.map html_of_refereed refereed_publications$ >>;
  right = <:html<
    <p>My $dblp$ page lists some of my publications.</>
    <h1>Tech reports</>
    $list:List.map html_of_tech tech_publications$ >>;
}

(* Projects *)
let projects = {
  left = <:html<
    <h1>Current projects</>
    $list:List.map html_of_project current_projects$ >>;
  right = <:html<
    <h1>Past projects</>
    $list:List.map html_of_project past_projects$ >>;
}

(* Home page *)
let home = {
  left = <:html<
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
    are hosted on $github$.</> >>;
  right = <:html< <div class="image"><img src="thomas.png"/></> >>;
}

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
      <div class="body">$html_of_body body$</>
      <div class="footer">$footer$</>
    </>
  </>
  >>

let make_nav pages =
  let one (l,_) = html_of_link l in
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
      Generated by $htcaml$ and $cass$.
    >> in
  let header = make_nav pages in
  let aux (link, contents) =
    let chan = open_out ("www/" ^ link.href) in
    let page = create ~title:link.text ~header ~body:contents ~footer in
    output_string chan (Html.to_string page);
    close_out chan 
in
  List.iter aux pages

let () =
  Printf.printf "Generating index.html and papers.html... %!";
  process [
    { text="home"; href="index.html" },  home;
    { text="papers"; href="papers.html" }, papers;
    { text="projects"; href="projects.html" }, projects;
  ];
  Printf.printf "[Done]\n"
