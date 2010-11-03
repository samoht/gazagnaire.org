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

let default_font = <:css<
    font-family: "Trebuchet MS", Arial, Verdana;
    color: black;
  >>

let default_bg_color =
  <:css< background-color: #D8D8D8; >>

let no_padding = <:css<
    margin: 0;
    padding: 0;
  >>

let default_padding = <:css<
    margin: 1em 1em 1em 1em;
  >>

let bg_color_title1 = <:css< #F5D0A9 >>
let bg_color_title2 = <:css< #A9D0F5 >>

module Body = struct

  let fonts = <:css<
    $default_font$;
    background-color: white; 
    font-size: 14px;
    text-align:justify;
    >>

  let inner_padding = <:css<
    padding: 5%;
    border: 0;
    margin: 0;
    >>

  let columns = <:css<
    .left {
      $inner_padding$;
      float: left;
      width: 40%;
    }
    .right {
      $inner_padding$;
      float: right;
      width: 40%;
    }
    >>

  let style = <:css<
    .body {
      $fonts$;
      float: left;
      width: 100%;
    }

    body {
      $no_padding$;
      $default_bg_color$;
    }

    h1 {
      font-size: 16px;
      $no_padding$;
    }
    
    .image {
      text-align: center;
    }

    $columns$
    >>

end

module Header = struct

  let nav = <:css< .nav >>

  let bg_color = <:css< background-color: #2E2E2E; >>
  let fonts = <:css<
    color: white;
    font-size: 14px;
    >>

  let nav_style = <:css<
    $nav$ {
      text-align: center;
      $fonts$;
    }
  
    $nav$ ul {
      $no_padding$;
      display: block;
    }
    
    $nav$ li {
      display: inline;
    }

    $nav$ a {
      $fonts$;
      text-decoration: none;
    }

    $nav$ a:hover {
      background-color: grey;
    }
    >>

  let style = <:css<
    .header {
      $no_padding$;
      $bg_color$;
      $fonts$;
      color: white;
      padding-top: 2em;
      padding-bottom: 0.5em;
      border-bottom: solid 1px grey;
    } 
    $nav_style$
    >>

end

module Footer = struct
  let fonts = <:css< color: grey; font-size: 10px; text-align: center; >>

  let style = <:css<
    .footer {
      $no_padding$;
      $fonts$;
      clear: both;
      padding-bottom: 15em;
      border-top: solid 1px grey;
      $default_bg_color$;
    }
    >>
end

module Publication = struct
  let style = 
    <:css<
      .publication {
        padding: 2px;
        margin: 2px;
        margin-top: 10px;
      }

      .publication .title {
        font-weight: bold;
      }

      .refereed .title {
        background-color: $bg_color_title1$;
      }
      .tech .title {
        background-color: $bg_color_title1$;
      }

      .publication .authors {
        font-style: italic;
      }
    >>
end

module Project = struct
  let style =
    <:css<
      .project {
        margin: 2px;
        margin-bottom: 10px;
      }

      .project .name {
        font-weight: bold;
        text-align: right;
      }
      
      .current .name {
        background-color: $bg_color_title1$;
      }

      .past .name {
        background-color: $bg_color_title1$;
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
  $Body.style$
  $Header.style$
  $Footer.style$
  $Publication.style$
  $Project.style$
>>

let process () =
  let chan = open_out "www/style.css" in
  output_string chan (Css.to_string css);
  close_out chan

let () =
  Printf.printf "Generating style.css ...%!";
  process ();
  Printf.printf "[Done]\n"


    
