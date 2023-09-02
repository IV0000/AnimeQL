// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class PageQuery: GraphQLQuery {
  public static let operationName: String = "Page"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Page($perPage: Int, $sort: [MediaSort]) { Page(perPage: $perPage) { __typename media(sort: $sort) { __typename averageScore coverImage { __typename extraLarge } description episodes genres title { __typename romaji english } duration format type } } }"#
    ))

  public var perPage: GraphQLNullable<Int>
  public var sort: GraphQLNullable<[GraphQLEnum<MediaSort>?]>

  public init(
    perPage: GraphQLNullable<Int>,
    sort: GraphQLNullable<[GraphQLEnum<MediaSort>?]>
  ) {
    self.perPage = perPage
    self.sort = sort
  }

  public var __variables: Variables? { [
    "perPage": perPage,
    "sort": sort
  ] }

  public struct Data: AnilistApi.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AnilistApi.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("Page", Page?.self, arguments: ["perPage": .variable("perPage")]),
    ] }

    public var page: Page? { __data["Page"] }

    /// Page
    ///
    /// Parent Type: `Page`
    public struct Page: AnilistApi.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AnilistApi.Objects.Page }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("media", [Medium?]?.self, arguments: ["sort": .variable("sort")]),
      ] }

      public var media: [Medium?]? { __data["media"] }

      /// Page.Medium
      ///
      /// Parent Type: `Media`
      public struct Medium: AnilistApi.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AnilistApi.Objects.Media }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("averageScore", Int?.self),
          .field("coverImage", CoverImage?.self),
          .field("description", String?.self),
          .field("episodes", Int?.self),
          .field("genres", [String?]?.self),
          .field("title", Title?.self),
          .field("duration", Int?.self),
          .field("format", GraphQLEnum<AnilistApi.MediaFormat>?.self),
          .field("type", GraphQLEnum<AnilistApi.MediaType>?.self),
        ] }

        /// A weighted average score of all the user's scores of the media
        public var averageScore: Int? { __data["averageScore"] }
        /// The cover images of the media
        public var coverImage: CoverImage? { __data["coverImage"] }
        /// Short description of the media's story and characters
        public var description: String? { __data["description"] }
        /// The amount of episodes the anime has when complete
        public var episodes: Int? { __data["episodes"] }
        /// The genres of the media
        public var genres: [String?]? { __data["genres"] }
        /// The official titles of the media in various languages
        public var title: Title? { __data["title"] }
        /// The general length of each anime episode in minutes
        public var duration: Int? { __data["duration"] }
        /// The format the media was released in
        public var format: GraphQLEnum<AnilistApi.MediaFormat>? { __data["format"] }
        /// The type of the media; anime or manga
        public var type: GraphQLEnum<AnilistApi.MediaType>? { __data["type"] }

        /// Page.Medium.CoverImage
        ///
        /// Parent Type: `MediaCoverImage`
        public struct CoverImage: AnilistApi.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { AnilistApi.Objects.MediaCoverImage }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("extraLarge", String?.self),
          ] }

          /// The cover image url of the media at its largest size. If this size isn't available, large will be provided instead.
          public var extraLarge: String? { __data["extraLarge"] }
        }

        /// Page.Medium.Title
        ///
        /// Parent Type: `MediaTitle`
        public struct Title: AnilistApi.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { AnilistApi.Objects.MediaTitle }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("romaji", String?.self),
            .field("english", String?.self),
          ] }

          /// The romanization of the native language title
          public var romaji: String? { __data["romaji"] }
          /// The official english title
          public var english: String? { __data["english"] }
        }
      }
    }
  }
}
