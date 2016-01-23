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

let papers =
  <:html<
    <div class="row">
    <h2>Publications</h2>

    <p>My $dblp$ page lists some of my publications.</p>
    <br/>
    <h2>Refereed publications</h2>
    $list:List.map html_of_refereed refereed_publications$
    <h2>Tech reports</h2>
    $list:List.map html_of_tech tech_publications$
    </div>
 >>

(* Projects *)
let projects =
  <:html<
    <div class="row">
    <h2>Current Projects</h2>
    $list:List.map html_of_project current_projects$

    <h2>Past Projects</h2>
    $list:List.map html_of_project past_projects$
    </div>
  >>

(* Home page *)
let home =
  <:html<
  <div class="row">
    <div class="large-6 columns">

    <h2>Thomas Gazagnaire</h2>

    <p>I am engineer at $docker$. Previously, I co-founded $unikernel$, where
    I was Chief Architect, to
    make $unikernels$ easier to use so that they can be shipped and deployed
    everywhere, while I also was Senior Research
    Associate at the $computer_lab$. Before that, I was CTO of $ocamlpro$,
    Principal Virtualisation Engineer at $onapp$, and Senior Software Engineer
    at $citrix$. I completed my Ph.D on distributed systems at $inria$/$irisa$ in the
    $distribcom$ project and I obtained my Master and Bachelor degrees from
    $ens_lyon$ and $ens_cachan$.</p>

    I am one of the main authors of the
    the $mirage$ operating system library and the main developer of the $irmin$
    Git-like distributed store. I previously designed and lead the implementation
    of the $opam$ package manager, and I've worked on $xenserver$.

    <h2>Interests</h2>
    <p>My interests primarily involve the application of formal methods and
    functional programming languages to complex-system engineering problems.
    More generally,
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

    </div>

    <div class="large-6 columns">

    <br />
    <div class="image"><img src="thomas.png"/></div>
    <div class="contact">
      <a class="button" href="mailto:thomas@gazagnaire.org">thomas@gazagnaire.org</a>
    <h2>Links</h2>
    <ul>
      <li>A <a href="./fuconf14/">2048</a> Tutorial in OCaml.</li>
      <li>Various <a href="http://decks.openmirage.org/">slides</a> on MirageOS
          and Irmin.</li>
      <li>Une rapide <a href="http://www.dailymotion.com/video/x3ihqqa_conf-42-meetup-oups_tech?start=5026">introduction</a> à MirageOS</li>
    </ul>
    </div>
    </div>

  </div>
  >>

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
    <div class="body">$body$</div>
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
  let footer = <:html<
      <div class="row">
      &copy; 2010-2014 Thomas Gazagnaire ::
      Last modified : $str:string_of_time ()$ ::
      Generated by $cow$.
      </div>
    >>
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
