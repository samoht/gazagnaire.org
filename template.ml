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

(* color tweaks for lists *)
let interleave_class classes l =
  let i = ref 0 in
  let n = Array.length classes in
  let get () =
    let res = classes.(!i mod n) in
    incr i;
    res in
  List.map (fun elt -> <:html< <div class=$str:get ()$>$elt$</div> >>) l

let classes = [| "kind1"; "kind2" |]

let map_i g l = interleave_class classes (List.map g l)

(* People *)
let papers = {
  left = <:html<
    <h1>Refereed publications</h1>
    $list:map_i html_of_refereed refereed_publications$ >>;
  right = <:html<
    <p>My $dblp$ page lists some of my publications.</p>
    <h1>Tech reports</h1>
    $list:map_i html_of_tech tech_publications$ >>;
}

(* Projects *)
let projects = {
  left = <:html<
    <h1>Current projects</h1>
    $list:List.map html_of_project current_projects$ >>;
  right = <:html<
    <h1>Past projects</h1>
    $list:List.map html_of_project past_projects$ >>;
}

(* Home page *)
let home = {
  left = <:html<
    <h1>Thomas Gazagnaire</h1>
    <p>I am a postdoctoral fellow at $inria_sop$, in the $indes$ project.
    Previously, I have been working in $citrix$ on $xenserver$ and $xcp$
    as a senior software engineer.
    I completed my Ph.D in 2008 at $irisa$ in the $distribcom$ project.
    I obtained my Master and Bachelor degrees from $ens_lyon$ and $ens_cachan$.</p>

    <p>My research interests primarily involve the application of formal methods and
    functional programming languages to complex-system engineering problems. More generally,
    I have a wide range of research and application interests including:</p>
    <ul>
      <li>Cloud-computing;</li>
      <li>Distributed and concurrent systems;</li>
      <li>Verification (model-checking) of complex systems;</li>
      <li>Automatic fault-diagnosis and monitoring of complex systems;</li>
      <li>Application of functional programming to real-world problems;</li>
      <li>Compilation and optimization techniques;</li>
      <li>Partial-order theory.</li>
    </ul>
    <p>I am doing most of my software developments in $ocaml$. My projects
    are hosted on $github$.</p> >>;
  right = <:html< <div class="image"><img src="thomas.png"/></div> >>;
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
      <title>Thomas Gazagnaire :: $str:title$</title>
      <link rel='stylesheet' href='style.css' type='text/css' media='all'/>
    </head>
    <body>
      <div class="header">$header$</div>
      <div class="body">$html_of_body body$</div>
      <div class="footer">$footer$</div>
    </body>
  </html>
  >>

let make_nav pages =
  let one (l,_) = html_of_link l in
  let inter = <:html< <li>::</li> >> in
  let rec aux = function
    | []   -> []
    | [h]  -> [one h]
    | h::t -> (one h) :: inter :: aux t in
  <:html<
    <div class="nav"><ul>$list:aux pages$</ul></div>
  >>

let process pages =
  Html.set_encoding `ISO_8859_1;
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
