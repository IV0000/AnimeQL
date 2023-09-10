// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct MediaFragment: AnilistApi.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment MediaFragment on Media { __typename episodes title { __typename english romaji } averageScore coverImage { __typename medium } id }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { AnilistApi.Objects.Media }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("episodes", Int?.self),
    .field("title", Title?.self),
    .field("averageScore", Int?.self),
    .field("coverImage", CoverImage?.self),
    .field("id", Int.self),
  ] }

  /// The amount of episodes the anime has when complete
  public var episodes: Int? { __data["episodes"] }
  /// The official titles of the media in various languages
  public var title: Title? { __data["title"] }
  /// A weighted average score of all the user's scores of the media
  public var averageScore: Int? { __data["averageScore"] }
  /// The cover images of the media
  public var coverImage: CoverImage? { __data["coverImage"] }
  /// The id of the media
  public var id: Int { __data["id"] }

  /// Title
  ///
  /// Parent Type: `MediaTitle`
  public struct Title: AnilistApi.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AnilistApi.Objects.MediaTitle }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("english", String?.self),
      .field("romaji", String?.self),
    ] }

    /// The official english title
    public var english: String? { __data["english"] }
    /// The romanization of the native language title
    public var romaji: String? { __data["romaji"] }
  }

  /// CoverImage
  ///
  /// Parent Type: `MediaCoverImage`
  public struct CoverImage: AnilistApi.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AnilistApi.Objects.MediaCoverImage }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("medium", String?.self),
    ] }

    /// The cover image url of the media at medium size
    public var medium: String? { __data["medium"] }
  }
}
