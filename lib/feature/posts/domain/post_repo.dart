abstract class PostRepo {
  Future fetchPosts();
  Future createPost(Map args);
}
