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

let color1 = <:css< #42A2D2 >>
let color2 = <:css< whiteSmoke >>

let dashed_links name color =
  <:css<
      $name$ a {
        color: $color$;
        text-decoration: none;
        border-bottom: 1px dashed $color$;
      }

      $name$ a:hover {
        color: $color$;
        text-decoration: none;
        border-bottom: 1px solid $color$;
      }
  >>

module Body = struct

  let bg_color = <:css< white >>
  let fg_color = <:css< #7F7B7B >>

  let fonts = <:css<
    background-color: $bg_color$;
    color: $fg_color$;
    font-size: 0.9em;
    text-align: justify;
    >>

  let inner_padding = <:css<
    padding: 5%;
    border: 0;
    margin: 0;
    >>

  let columns = <:css<
    .body .two_columns {
     overflow: hidden;
    }

    .body .two_columns .left {
      $inner_padding$;
      padding-left: 8%;
      padding-right: 2%;
      float: left;
      width: 40%;
    }

    .body .two_columns .right {
      $inner_padding$;
      padding-right: 8%;
      padding-left: 2%;
      float: right;
      width: 40%;
    }
    >>

  let one_column = <:css<
    .body .one_column {
      padding-top: 5%;
      padding-bottom: 5%;
      padding-left: 20%;
      padding-right: 20%;
    }
    >>

  let style = <:css<
    $one_column$;
    $columns$;

    .body {
      $fonts$;
      width: 100%;
    }

    .body p, .body ul {
      padding: 0.5em;
    }

    .body li {
      margin-left: 4em;
    }

    $dashed_links <:css< .body >> fg_color$;

    .body h1 {
      background-color: $color1$;
      color: $bg_color$;
      margin: 0.5em 0px 1em;
      padding: 0.3em;
      font-size: 1.5em;
      margin-bottom: 0.7em;
      font-weight: bold;
      $Css.rounded$;
    }

    .body h2 {
      padding-left: 1em;
      margin-top: 1em;
      margin-bottom: 1em;
      border-bottom: 1px dashed $fg_color$;
    }

    .body .image img {
      width: 80%;
    }

    .body .image {
      width: 30%;
      float: left;
      padding: 5%;
    }

    .body .contact {
      padding: 5%;
      float: right;
      width: 50%;
    }
    >>

end

module Header = struct

  let bg_color = <:css< #363842 >>
  let fg_color = <:css< #888 >>

  let nav = <:css< .header .nav >>

  let fonts = <:css<
    color: $fg_color$;
    background-color: $bg_color$;
    font-size: 0.9em;
    line-height: 2em;
    >>

  let nav_style = <:css<
    $nav$ {
      $fonts$;
      margin-left: 10%;
    }

    $nav$ li {
      display: inline-block;
      padding-left: 1em;
      padding-right: 1em;
    }

    $nav$ a {
      color: $fg_color$;
      text-decoration: none;
    }

    $nav$ a:hover {
      color: $fg_color$;
      text-decoration: none;
      border-bottom: 1px solid $fg_color$;
    }

    $nav$ #current {
      display: inline-block;
      background-color: $Body.bg_color$;
      padding-left: 1em;
      padding-right: 1em;
      $Css.box_shadow$;
    }
    >>

  let style = <:css<
    .header {
      $fonts$;
      background-color: $bg_color$;
    } 
    $nav_style$
    >>

end

module Footer = struct
  let bg_color = <:css< #363842 >>
  let fg_color = <:css< #888 >>

  let fonts = <:css<
    color: $fg_color$;
    background-color: $bg_color$;
    font-size: 0.6em;
    text-align: center;
  >>

  let style = <:css<
    .footer {
      $fonts$;
      clear: both;
      padding-top: 0.5em;
      padding-bottom: 40px;
    }
    $dashed_links <:css< .footer >> fg_color$
    >>
end

module Publication = struct
  let style = 
    <:css<
      .author {
        display: inline;
        font-style: italic;
      }

      $dashed_links <:css< .publication .author >> Body.fg_color$;

      .publication {
        margin: 1em;
        padding: 0.5em;
        $Css.box_shadow$;
        $Css.rounded$;
      }
      
      .kind1 .publication {
        background-color: $color2$;
      }

      .kind2 .publication {
        background-color: $Body.bg_color$;
      }

      .publication .title {
        color: $color1$;
      }

      .publication .where {
        display: inline;
      }

      .publication .year {
        margin-right: 4px;
        display: inline;
        float: right;
        $Css.rounded$;
        padding: 2px;
        color: #CC3300;
      }

      .publication .files {
        margin-right: 4px;
        text-align: center;
      }
    >>
end

module Project = struct
  let style =
    <:css<
      .project {
        margin: 2em;
        padding: 0.5em;
        background-color: $color2$;
        $Css.box_shadow$;
        $Css.rounded$;
      }

      .project .name {
        padding-right: 10px;
        font-weight: bold;
        text-align: right;
        color: $color1$;
      }
      
      .project .description {
        padding: 2px;
      }

      .project .links {
        text-align: center;
      }
    >>
end

let css = <:css<
  $Css.reset_padding$;
  $Body.style$;
  $Header.style$;
  $Footer.style$;
  $Publication.style$;
  $Project.style$;

  body {
    font-family: arial, verdana, sans-serif;
    background-color: $Footer.bg_color$;
  }
>>

let process () =
  let chan = open_out "www/style.css" in
  output_string chan (Css.to_string css);
  close_out chan

let () =
  Printf.printf "Generating style.css ...%!";
  process ();
  Printf.printf "[Done]\n"
