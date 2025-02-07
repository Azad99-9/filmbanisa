import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmbanisa/models/movie.dart';
import 'package:filmbanisa/services/db_service.dart';

List<String> dummyPosterUrls = [
  'https://images.saymedia-content.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:eco%2Cw_1200/MTk4NjA1NDYzMzkzMTUwNDAz/the-shawshank-redemption-1994-movie-review.jpg'
];

List<Map<String, dynamic>> dummyMovies = [
  // Movies
  {
    'title': 'Inception',
    'description': 'A thief who enters the dreams of others to steal secrets from their subconscious.',
    'posterUrl': dummyPosterUrls[0],
    'releaseDate': '2010-07-16',
    'type': MovieType.movie,
    'rating': 8.8,
    'genres': ['Action', 'Sci-Fi', 'Thriller'],
    'threadId': 'inception_thread',
  },
  {
    'title': 'The Shawshank Redemption',
    'description': 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.',
    'posterUrl': dummyPosterUrls[0],
    'releaseDate': '1994-09-23',
    'type': MovieType.movie,
    'rating': 9.3,
    'genres': ['Drama'],
    'threadId': 'shawshank_thread',
  },
  {
    'title': 'Interstellar',
    'description': 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.',
    'posterUrl': dummyPosterUrls[0],
    'releaseDate': '2014-11-07',
    'type': MovieType.movie,
    'rating': 8.6,
    'genres': ['Adventure', 'Drama', 'Sci-Fi'],
    'threadId': 'interstellar_thread',
  },
  {
    'title': 'The Dark Knight',
    'description': 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
    'posterUrl': dummyPosterUrls[0],
    'releaseDate': '2008-07-18',
    'type': MovieType.movie,
    'rating': 9.0,
    'genres': ['Action', 'Crime', 'Drama'],
    'threadId': 'dark_knight_thread',
  },
  {
    'title': 'Pulp Fiction',
    'description': 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.',
    'posterUrl': dummyPosterUrls[0],
    'releaseDate': '1994-10-14',
    'type': MovieType.movie,
    'rating': 8.9,
    'genres': ['Crime', 'Drama'],
    'threadId': 'pulp_fiction_thread',
  },
  {
    'title': 'The Matrix',
    'description': 'A computer programmer discovers that reality as he knows it is a simulation created by machines, and joins a rebellion to break free.',
    'posterUrl': dummyPosterUrls[0],
    'releaseDate': '1999-03-31',
    'type': MovieType.movie,
    'rating': 8.7,
    'genres': ['Action', 'Sci-Fi'],
    'threadId': 'matrix_thread',
  },
  {
    'title': 'Gladiator',
    'description': 'A former Roman General sets out to exact vengeance against the corrupt emperor who murdered his family and sent him into slavery.',
    'posterUrl': dummyPosterUrls[0],
    'releaseDate': '2000-05-05',
    'type': MovieType.movie,
    'rating': 8.5,
    'genres': ['Action', 'Adventure', 'Drama'],
    'threadId': 'gladiator_thread',
  },
  {
    'title': 'The Godfather',
    'description': 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.',
    'posterUrl': dummyPosterUrls[0],
    'releaseDate': '1972-03-24',
    'type': MovieType.movie,
    'rating': 9.2,
    'genres': ['Crime', 'Drama'],
    'threadId': 'godfather_thread',
  },
  {
    'title': 'Forrest Gump',
    'description': 'The presidencies of Kennedy and Johnson, the Vietnam War, the Watergate scandal and other historical events unfold from the perspective of an Alabama man with an IQ of 75.',
    'posterUrl': dummyPosterUrls[0],
    'releaseDate': '1994-07-06',
    'type': MovieType.movie,
    'rating': 8.8,
    'genres': ['Drama', 'Romance'],
    'threadId': 'forrest_gump_thread',
  },
  {
    'title': 'Fight Club',
    'description': 'An insomniac office worker and a devil-may-care soapmaker form an underground fight club that evolves into something much more.',
    'posterUrl': dummyPosterUrls[0],
    'releaseDate': '1999-10-15',
    'type': MovieType.movie,
    'rating': 8.8,
    'genres': ['Drama'],
    'threadId': 'fight_club_thread',
  },

  // Web Series
  {
    'title': 'Breaking Bad',
    'description': 'A high school chemistry teacher turned methamphetamine manufacturer partners with a former student to secure his family\'s financial future as he battles terminal lung cancer.',
    'posterUrl': dummyPosterUrls[0],
    'releaseDate': '2008-01-20',
    'type': MovieType.webSeries,
    'rating': 9.5,
    'genres': ['Crime', 'Drama', 'Thriller'],
    'threadId': 'breaking_bad_thread',
  },
  {
    'title': 'Game of Thrones',
    'description': 'Nine noble families fight for control over the lands of Westeros, while an ancient enemy returns after being dormant for millennia.',
    'posterUrl': dummyPosterUrls[0],
    'releaseDate': '2011-04-17',
    'type': MovieType.webSeries,
    'rating': 9.3,
    'genres': ['Action', 'Adventure', 'Drama'],
    'threadId': 'got_thread',
  },
  {
    'title': 'Stranger Things',
    'description': 'When a young boy disappears, his mother, a police chief, and his friends must confront terrifying supernatural forces in order to get him back.',
    'posterUrl': dummyPosterUrls[0],
    'releaseDate': '2016-07-15',
    'type': MovieType.webSeries,
    'rating': 8.7,
    'genres': ['Drama', 'Fantasy', 'Horror'],
    'threadId': 'stranger_things_thread',
  },
  {
    'title': 'The Crown',
    'description': 'Follows the political rivalries and romance of Queen Elizabeth II\'s reign and the events that shaped the second half of the twentieth century.',
    'posterUrl': dummyPosterUrls[0],
    'releaseDate': '2016-11-04',
    'type': MovieType.webSeries,
    'rating': 8.7,
    'genres': ['Biography', 'Drama', 'History'],
    'threadId': 'crown_thread',
  },
  {
    'title': 'The Mandalorian',
    'description': 'The travels of a lone bounty hunter in the outer reaches of the galaxy, far from the authority of the New Republic.',
    'posterUrl': dummyPosterUrls[0],
    'releaseDate': '2019-11-12',
    'type': MovieType.webSeries,
    'rating': 8.8,
    'genres': ['Action', 'Adventure', 'Sci-Fi'],
    'threadId': 'mandalorian_thread',
  },
  {
    'title': 'Chernobyl',
    'description': 'In April 1986, an explosion at the Chernobyl nuclear power plant in the Union of Soviet Socialist Republics becomes one of the world\'s worst man-made catastrophes.',
    'posterUrl': dummyPosterUrls[0],
    'releaseDate': '2019-05-06',
    'type': MovieType.webSeries,
    'rating': 9.4,
    'genres': ['Drama', 'History', 'Thriller'],
    'threadId': 'chernobyl_thread',
  },
  {
    'title': 'The Witcher',
    'description': 'Geralt of Rivia, a solitary monster hunter, struggles to find his place in a world where people often prove more wicked than beasts.',
    'posterUrl': dummyPosterUrls[0],
    'releaseDate': '2019-12-20',
    'type': MovieType.webSeries,
    'rating': 8.2,
    'genres': ['Action', 'Adventure', 'Fantasy'],
    'threadId': 'witcher_thread',
  },
  {
    'title': 'Money Heist',
    'description': 'An unusual group of robbers attempt to carry out the most perfect robbery in Spanish history - stealing 2.4 billion euros from the Royal Mint of Spain.',
    'posterUrl': dummyPosterUrls[0],
    'releaseDate': '2017-05-02',
    'type': MovieType.webSeries,
    'rating': 8.3,
    'genres': ['Action', 'Crime', 'Drama'],
    'threadId': 'money_heist_thread',
  },
  {
    'title': 'The Office',
    'description': 'A mockumentary on a group of typical office workers, where the workday consists of ego clashes, inappropriate behavior, and tedium.',
    'posterUrl': dummyPosterUrls[0],
    'releaseDate': '2005-03-24',
    'type': MovieType.webSeries,
    'rating': 8.9,
    'genres': ['Comedy'],
    'threadId': 'office_thread',
  },
  {
    'title': 'Black Mirror',
    'description': 'An anthology series exploring a twisted, high-tech multiverse where humanity\'s greatest innovations and darkest instincts collide.',
    'posterUrl': dummyPosterUrls[0],
    'releaseDate': '2011-12-04',
    'type': MovieType.webSeries,
    'rating': 8.8,
    'genres': ['Drama', 'Sci-Fi', 'Thriller'],
    'threadId': 'black_mirror_thread',
  },
];

class DummyDataUploader {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _moviesCollection = DbService.moviesCollection;

  //  Future<void> uploadDummyMovies() async {
  //   // Using batch write for better performance
  //   final WriteBatch batch = _firestore.batch();

  //   // Get all existing movie documents
  //   final QuerySnapshot movieDocs = await _moviesCollection.get();
  //   final List<DocumentSnapshot> docs = movieDocs.docs;

  //   // Update each document with a random poster URL
  //   for (int i = 0; i < docs.length; i++) {
  //     final String randomPosterUrl = dummyPosterUrls[i % dummyPosterUrls.length];
  //     batch.update(docs[i].reference, {'posterUrl': randomPosterUrl});
  //   }

  //   try {
  //     await batch.commit();
  //     print('Successfully updated poster URLs in Firestore!');
  //   } catch (e) {
  //     print('Error updating poster URLs: $e');
  //   }
  // }

  Future<void> uploadDummyMovies() async {
    final WriteBatch batch = _firestore.batch();

    for (var movieData in dummyMovies) {
      DocumentReference docRef = _moviesCollection.doc();
      movieData['id'] = docRef.id;
      batch.set(docRef, movieData);
    }

    try {
      await batch.commit();
      print('Successfully uploaded dummy movies to Firestore!');
    } catch (e) {
      print('Error uploading dummy movies: $e');
    }
  }
} 