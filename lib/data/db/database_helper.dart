import 'package:dicoding_news_app/data/model/articles.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblBookmark = 'bookmarks';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/newsapp.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblBookmark (
             url TEXT PRIMARY KEY,
             author TEXT,
             title TEXT,
             description TEXT,
             urlToImage TEXT,
             publishedAt TEXT,
             content TEXT
           )     
        ''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();
    return _database;
  }

  Future<void> insertBookMark(Article article) async {
    final db = await database;
    await db!.insert(_tblBookmark, article.toJson());
  }

  Future<List<Article>> getBookMarks() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(_tblBookmark);

    return result.map((res) => Article.fromJson(res)).toList();
  }

  Future<Map<String, dynamic>> getBookMarkByUrl(String url) async {
    // Mendapatkan akses ke database
    final db = await database;

    // Melakukan query ke tabel bookmark berdasarkan URL
    List<Map<String, dynamic>> result = await db!.query(
      _tblBookmark,
      where: 'url = ?',
      whereArgs: [url],
    );

    if (result.isNotEmpty) {
      // Jika ada hasil, kembalikan data bookmark pertama yang ditemukan
      return result.first;
    } else {
      // Jika tidak ada hasil, kembalikan objek map kosong
      return {};
    }
  }

  Future<void> removeBookmark(String url) async {
    final db = await database;

    await db!.delete(
      _tblBookmark,
      where: 'url = ?',
      whereArgs: [url],
    );
  }
}
