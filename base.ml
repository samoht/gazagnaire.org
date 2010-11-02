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

