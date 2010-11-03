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

type people = {
  name : string;
  link: string;
}

type kind =
  | Refereed
  | Tech

type publication = {
  authors: people list;
	title: string;
	where: string;
	year: int;
	kind: kind;
	files: (string * string) list;
}

let short_name authors year =
  let aux a =
		let space = String.rindex a.name ' ' in
		String.sub a.name (space+1) 1 in
	let base = match authors with
    | [a] -> a.name
    | _   -> String.concat "" (List.map aux authors) in
  Printf.sprintf "%s%.2d" base (year - 2000)

type project = {
  p_name: string;
  p_description: Html.t;
  p_links: (string * string) list;
}

