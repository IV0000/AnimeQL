// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class PageQuery: GraphQLQuery {
    public static let operationName: String = "Page"
    public static let operationDocument: ApolloAPI.OperationDocument = .init(
        definition: .init(
            #"query Page($perPage: Int) { Page(perPage: $perPage) { __typename mediaList { __typename media { __typename averageScore coverImage { __typename extraLarge } description episodes genres title { __typename romaji english } } } } }"#
        ))

    public var perPage: GraphQLNullable<Int>

    public init(perPage: GraphQLNullable<Int>) {
        self.perPage = perPage
    }

    public var __variables: Variables? { ["perPage": perPage] }

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
                .field("mediaList", [MediaList?]?.self),
            ] }

            public var mediaList: [MediaList?]? { __data["mediaList"] }

            /// Page.MediaList
            ///
            /// Parent Type: `MediaList`
            public struct MediaList: AnilistApi.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: ApolloAPI.ParentType { AnilistApi.Objects.MediaList }
                public static var __selections: [ApolloAPI.Selection] { [
                    .field("__typename", String.self),
                    .field("media", Media?.self),
                ] }

                public var media: Media? { __data["media"] }

                /// Page.MediaList.Media
                ///
                /// Parent Type: `Media`
                public struct Media: AnilistApi.SelectionSet {
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

                    /// Page.MediaList.Media.CoverImage
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

                    /// Page.MediaList.Media.Title
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
}
