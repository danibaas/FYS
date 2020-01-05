import de.bezier.data.sql.*;

MySQL sql;

void initializeDatabase() {
  String databaseName = "oege.ie.hva.nl";
  String databaseSchema = "zbaasdr";
  String username = "baasdr";
  String password = "l#aEkJ7cojymzj";
  sql = new MySQL(instance, databaseName, databaseSchema, username, password);
  if (sql.connect()) {
    sql.execute("CREATE TABLE IF NOT EXISTS Account (user_id int AUTO_INCREMENT, username varchar(150), password varchar(150), PRIMARY KEY(user_id));");
    sql.execute("CREATE TABLE IF NOT EXISTS Money (user_id int, coins int, PRIMARY KEY (user_id), FOREIGN KEY (user_id) REFERENCES Account(user_id));");
    sql.execute("CREATE TABLE IF NOT EXISTS Highscore (user_id int, score float, PRIMARY KEY (user_id), FOREIGN KEY (user_id) REFERENCES Account(user_id));");
    sql.execute("CREATE TABLE IF NOT EXISTS Item (itemid int AUTO_INCREMENT, name varchar(200), value int, PRIMARY KEY (itemid));");
    sql.execute("CREATE TABLE IF NOT EXISTS Shop (user_id int, itemid int, PRIMARY KEY (user_id, itemid), FOREIGN KEY (user_id) REFERENCES Account(user_id), "
      + "FOREIGN KEY (itemid) REFERENCES Item(itemid));");
    sql.execute("CREATE TABLE IF NOT EXISTS Achievement (achievementid int AUTO_INCREMENT, name varchar(300), PRIMARY KEY (achievementid));");
    sql.execute("CREATE TABLE IF NOT EXISTS Achieved (user_id int, achievementid int, PRIMARY KEY (user_id, achievementid), FOREIGN KEY (user_id) REFERENCES Account(user_id), "
      + "FOREIGN KEY (achievementid) REFERENCES Achievement(achievementid));");
    sql.close();
  }
}
