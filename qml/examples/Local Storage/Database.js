.pragma library
.import QtQuick.LocalStorage 2.0 as Sql

var db = Sql.LocalStorage.openDatabaseSync("Local Storage Example", "1.0", "Sample database", 100000);

function init() {
  db.transaction(
    function(tx) {
      tx.executeSql('CREATE TABLE IF NOT EXISTS SampleTable(id INTEGER PRIMARY KEY, content TEXT);')
    }
  )
}

function getRecords() {
  var records = new Array(0)
  db.transaction(
    function(tx) {
      var rs = tx.executeSql('SELECT * FROM SampleTable;');
      for (var i = 0; i < rs.rows.length; i++) {
        var record = new Object
        record.id = rs.rows.item(i).id
        record.content = rs.rows.item(i).content
        records.push(record)
      }
    }
  );
  return records
}

function insertRecord(content) {
  db.transaction(
    function(tx) {
      tx.executeSql('INSERT INTO SampleTable VALUES(NULL, ?);', [ content ]);
    }
  );
}

function removeRecord(id) {
  db.transaction(
    function(tx) {
      tx.executeSql('DELETE FROM SampleTable WHERE id=?;', [ id ]);
    }
  );
}
