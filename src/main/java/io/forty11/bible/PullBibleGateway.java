package io.forty11.bible;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;

import io.forty11.j.J;
import io.forty11.sql.Rows.Row;
import io.forty11.sql.Sql;
import io.forty11.web.Web;
import io.forty11.web.Web.Response;

public class PullBibleGateway
{

   public static void main(String[] args) throws Exception
   {
      PullBibleGateway pull = new PullBibleGateway();
      pull.pull(args);
   }

   public void pull(String[] args) throws Exception
   {
      String driver = args[0];
      String dburl = args[1];
      String user = args[2];
      String pass = args[3];

      Class.forName(driver);
      Connection conn = DriverManager.getConnection(dburl, user, pass);

      String css = J.read("files/combined.css");

      //for (Row row : Sql.selectRows(conn, "SELECT * FROM Bible where book = 'Luke'"))
      for (Row row : Sql.selectRows(conn, "SELECT * FROM BibleBook"))
      {
         String book = row.getString("book");
         int chapters = row.getInt("chapters");

         for (int i = 1; i <= chapters; i++)
         {
            try
            {
               String url = "https://www.biblegateway.com/passage/?search=" + book.replaceAll(" ", "%20") + "+" + i + "&version=NLT";

               System.out.println(url);
               String content = getContent(url);

               int idx1 = content.indexOf("<div class=\"version-NLT result-text-style-normal text-html \">");
               int idx2 = content.indexOf("<div class=\"publisher-info-bottom with-single\">");

               content = content.substring(idx1, idx2);

               String template = J.read("files/biblegatewaytemplate.html");

               content = template.replace("PASTE_HERE", content);
               content = content.replace("href=\"/", "href=\"https://www.biblegateway.com/");

               idx1 = content.indexOf("<span class=\"passage-display-version\">");
               if (idx1 > 0)
               {
                  idx2 = content.indexOf("</span>", idx1);
                  content = content.substring(0, idx1) + content.substring(idx2 + 7, content.length());
               }

               J.write("files/html-to-convert.html", content);
               J.run("/usr/local/bin/node files/cssinline.js");

               content = J.read("files/html-converted.html");
               content = content.replace("margin-top: 30px;", "");
               content = content.replace("background-color: #f6f4f2;", "background-color: #ffffff;");
               content = content.replace("color: #631e16", "color: #000000");

               J.write("files/html-converted.html", content);//for debug

               if (content != null)
               {
                  Sql.execute(conn, "INSERT INTO BibleChapter (book, chapter, text) values(?,?,?) ON DUPLICATE KEY UPDATE `book`=VALUES(`book`), `chapter`=VALUES(`chapter`), `text`=VALUES(`text`) ", book, i, content);
               }
            }
            catch (Exception ex)
            {
               ex.printStackTrace();
            }
         }
      }
   }

   String getContent(String url)
   {
      String slug = J.slugify(url);
      String path = "files/downloads/" + slug;
      File f = new File(path);
      String content = null;
      if (f.exists())
      {
         content = J.read(path);
      }
      else
      {
         Response r = Web.get(url, 1).get();
         if (r.code == 200)
         {
            content = r.getContent();
            J.write(path, content);
         }
         else
         {
            System.err.println("ERROR: " + url + " - " + r.getError() + " - " + r.getStatus());
         }
      }
      return content;
   }
}
