// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CarouselMediaQuery: GraphQLQuery {
  public static let operationName: String = "CarouselMedia"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query CarouselMedia($perPage: Int, $type: MediaType, $sort: [MediaSort]) { Page(perPage: $perPage) { __typename media(type: $type, sort: $sort) { __typename ...MediaFragment } pageInfo { __typename currentPage } } }"#,
      fragments: [MediaFragment.self]
    ))

  public var perPage: GraphQLNullable<Int>
  public var type: GraphQLNullable<GraphQLEnum<MediaType>>
  public var sort: GraphQLNullable<[GraphQLEnum<MediaSort>?]>

  public init(
    perPage: GraphQLNullable<Int>,
    type: GraphQLNullable<GraphQLEnum<MediaType>>,
    sort: GraphQLNullable<[GraphQLEnum<MediaSort>?]>
  ) {
    self.perPage = perPage
    self.type = type
    self.sort = sort
  }

  public var __variables: Variables? { [
    "perPage": perPage,
    "type": type,
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
        .field("media", [Medium?]?.self, arguments: [
          "type": .variable("type"),
          "sort": .variable("sort")
        ]),
        .field("pageInfo", PageInfo?.self),
      ] }

      public var media: [Medium?]? { __data["media"] }
      /// The pagination information
      public var pageInfo: PageInfo? { __data["pageInfo"] }

      /// Page.Medium
      ///
      /// Parent Type: `Media`
      public struct Medium: AnilistApi.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AnilistApi.Objects.Media }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(MediaFragment.self),
        ] }

        /// The amount of episodes the anime has when complete
        public var episodes: Int? { __data["episodes"] }
        /// The official titles of the media in various languages
        public var title: MediaFragment.Title? { __data["title"] }
        /// A weighted average score of all the user's scores of the media
        public var averageScore: Int? { __data["averageScore"] }
        /// The cover images of the media
        public var coverImage: MediaFragment.CoverImage? { __data["coverImage"] }
        /// The id of the media
        public var id: Int { __data["id"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var mediaFragment: MediaFragment { _toFragment() }
        }
      }

      /// Page.PageInfo
      ///
      /// Parent Type: `PageInfo`
      public struct PageInfo: AnilistApi.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { AnilistApi.Objects.PageInfo }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("currentPage", Int?.self),
        ] }

        /// The current page
        public var currentPage: Int? { __data["currentPage"] }
      }
    }
  }
}
