//
//  CommentViewModel.swift
//
//  Created by Stepan Maksymov.
//  Copyright © 2020 FindByte. All rights reserved.
//

import Foundation

class CommentViewModel {

	
	weak var dataSource : BaseDataSource<CommentDisplayable>?
	init(dataSource : BaseDataSource<CommentDisplayable>?) {
		self.dataSource = dataSource
	}
	private var commentDisplayableInternal = [CommentDisplayable]()

}

extension CommentViewModel {
	
	// Get comments from web to make them live (if success, we update local database), if failed attempt to get them from local database,
	// If both failed then display that we need connection to load at least one time.

	func getData() {
		getCommentsWeb(completion: {[weak self] result in
			switch(result){
			case .failure:
				if let comments = self?.getCommentsCore(), comments.count > 0 {
					self?.commentDisplayableInternal = comments
					guard let commentDataSource = self?.dataSource as? CommentDataSource else { return }
					guard let comments = self?.getCommentByPostId(postId: commentDataSource.postModel?.id ?? 0) else { return }
					DispatchQueue.main.async {
						self?.dataSource?.data.value = comments
					}
				} else {
					print("Failed to get comments")
				}
			case .success(let commentsData):
				self?.commentDisplayableInternal = commentsData
				guard let commentDataSource = self?.dataSource as? CommentDataSource else { return }
				guard let comments = self?.getCommentByPostId(postId: commentDataSource.postModel?.id ?? 0) else { return }
				DispatchQueue.main.async {
					self?.dataSource?.data.value = comments
				}
			}
		})
	}

	
	private func getCommentByPostId(postId: Int32) -> [CommentDisplayable]?{
		return commentDisplayableInternal.filter{$0.postId == postId}
	}
	
	
	private func getCommentsCore() -> [CommentCoreModel]? {
		let comments = CommentCoreModel.getAll(moc: CoreDataHelper.shared.managedObjectContext)
		return comments
	}
	
	private func getCommentsWeb(completion: @escaping (Result<[CommentWebModel], Error>) -> Void) {
		ApiHelper.shared.getRequest(urlString: ApiUrls.commentsUrl, completion: { result in
			switch result {
			case .failure(let error):
				completion(.failure(error))
			case .success(let data):
				let decoder = JSONDecoder()
				do {
					let tempComments = try decoder.decode([CommentWebModel].self, from: data)
					DatabaseHelper.shared.updateComments(comments: tempComments)
					completion(.success(tempComments))
				} catch {
					completion(.failure(error))
				}
			}
		})
	}
	
}
