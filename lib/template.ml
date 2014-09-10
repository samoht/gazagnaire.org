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
open Cow.Html

let papers = One_column
  <:html<
    <h1>Publications</h1>
    <p>My $dblp$ page lists some of my publications.</p>
    <br/>
    <h1>Refereed publications</h1>
    $list:List.map html_of_refereed refereed_publications$
    <h1>Tech reports</h1>
    $list:List.map html_of_tech tech_publications$
 >>


(* Projects *)
let projects = Two_columns (
  <:html<
    <h1>Current projects</h1>
    $list:List.map html_of_project current_projects$ >>,
  <:html<
    <h1>Past projects</h1>
    $list:List.map html_of_project past_projects$ >>;
  )

(* Home page *)
let home = Two_columns (
  <:html<
    <h1>Thomas Gazagnaire</h1>
    <p>I am a Senior Research Associate at the $computer_lab$ where I work on distributed
    systems and functional programming. I am one of the main author of the
    the $mirage$ operating system library and the $irmin$ distributed store.
    Before that, I was
    Chief Technical Officier at $ocamlpro$ where I designed and lead the implementation
    of $opam$ and Principal Virtualisation Engineer at $onapp$.</p>

    <p>I was also a postdoctoral fellow at $inria_sop$, in the $indes$ project
    and a Senior Software Engineer at $citrix$, working on $xenserver$.
    I completed my Ph.D in 2008 at $irisa$ in the $distribcom$ project.
    I obtained my Master and Bachelor degrees from $ens_lyon$ and $ens_cachan$.</p>

    <h2>Research</h2>
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
    <br/>
    <p>I am doing most of my software developments in $ocaml$. My projects
    are hosted on $github$.</p>
    <h2>Open Positions</h2>
    <p>I am looking for students interested to work on any project related to
       $mirage$. Ideal profiles: master in CS, with a taste of formal methods
       and a strong interest in Functional Programming and/or Operating System.
       Please send a resume (CV) and a motivation letter.</p>
       <ul>
       <li><a href="pub/m2.pdf">Weak Models of data consistency</a></li>
       <li>Large-scale monitoring of distributed applications</li>
       </ul>
   >>,
  <:html<
    <h1>Contact</h1>
    <div class="image"><img src="thomas.png"/></div>
    <div class="contact">
      <a class="button" href="mailto:thomas@gazagnaire.org">thomas@gazagnaire.org</a>
     <p>
      <h2>Office</h2>
      FN10, Computer Laboratory, <br/>
      University of Cambridge, <br/>
      15 JJ Thomson Avenue, <br />
      Cambridge CB3 0FD, UK
    </p>
   </div>
  >>
  )

(* Main *)
let string_of_time () =
  let t = Unix.localtime (Unix.time ()) in
  Printf.sprintf "%d/%d/%d" t.Unix.tm_mday (t.Unix.tm_mon + 1) (t.Unix.tm_year + 1900)

let create ~title ~header ~body ~footer =
  <:html<
<!--[if IE 9]><html class="lt-ie10" lang="en" > <![endif]-->
<html class="no-js" lang="en">

<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Thomas Gazagnaire :: $str:title$</title>
  <link rel="stylesheet" href="ext/css/normalize.css"/>
  <link rel="stylesheet" href="ext/css/foundation.css"/>
  <link rel="stylesheet" href="ext/css/app.css"/>
  <script src="ext/js/vendor/modernizr.js"> </script>
</head>
<body>
  <div class="wrapper">
    <div class="header">$header$</div>
    <div class="body">$html_of_body body$</div>
    <div class="push"> </div>
  </div>
  <div class="footer">$footer$</div>

  <script src="ext/js/vendor/jquery.js"></script>
  <script src="ext/js/foundation.min.js"></script>
  <script>
    $(document).foundation();
  </script>
</body>
</html>
  >>

let make_nav current pages =
  let one (l,_) =
    if l = current then
      <:html<<li class="active">$html_of_link l$</li>&>>
    else
      <:html<<li>$html_of_link l$</li>&>>
  in
  <:html<
<div class="contain-to-grid">
  <nav class="top-bar" data-topbar="" role="navigation">
    <ul class="title-area">
      <li class="name"><!-- Leave this empty --></li>
    </ul>
    <section class="top-bar-section">
      <ul class="left">$list:List.map one pages$</ul>
    </section>
  </nav>
</div>
  >>

let process pages =
  let footer = html_of_body (One_column <:html<
      &copy; 2010-2014 Thomas Gazagnaire ::
      Last modified : $str:string_of_time ()$ ::
      Generated by $cow$.
    >>)
  in
  let aux (link, contents) =
    let header = make_nav link pages in
    let chan = open_out ("www/" ^ link.href) in
    let page = create ~title:link.text ~header ~body:contents ~footer in
    output_string chan (Cow.Html.to_string page);
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
