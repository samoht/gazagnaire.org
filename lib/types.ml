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

type author = Cow.Html.link with html

let make_author name link =
  { Cow.Html.text = name; href = link }

type authors = author list

let html_of_authors la =
  let rec aux = function
    | [a]   -> <:html< $html_of_author a$.>>
    | [a;b] -> <:html< $html_of_author a$ and $html_of_author b$.>>
    | a::t  -> <:html< $html_of_author a$, $aux t$>>
    | []    -> <:html< >> in
  aux la

type publication = {
  title: string;
  authors: authors;
  where: string;
  files: Cow.Html.link list;
  year: int;
} with html

type refereed = publication with html

type tech = publication with html

let short_name authors year =
  let one a =
    let space = String.rindex a ' ' in
    String.sub a (space+1) 1 in
  let name a =
    let space = String.rindex a ' ' in
    String.sub a (space+1) (String.length a - space - 1) in
  let base = match authors with
    | [a] -> name a.Cow.Html.text
    | _   -> String.concat "" (List.map (fun x -> one x.Cow.Html.text) authors) in
  Printf.sprintf "%s%.2d" base (year - 2000)

let html_of_refereed p =
  html_of_refereed ~id:(short_name p.authors p.year) p

let html_of_tech p =
  html_of_tech ~id:(short_name p.authors p.year) p


type project = {
  name: string;
  description: Cow.Html.t;
  links: Cow.Html.link list;
}

let html_of_project t =
  <:html<
    <div class="project">
      <h3>$str:t.name$</h3>
      <blockquote>$t.description$
      $list:List.map Cow.Html.html_of_link t.links$
      </blockquote>
    </div>
  >>
