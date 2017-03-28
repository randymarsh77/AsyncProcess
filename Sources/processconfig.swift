import Foundation
import Gloss

public enum ProcessConfigError : Error
{
	case InvalidPath(path: String)
	case UnreachablePath(path: String)
}

public final class ProcessConfig: Glossy
{
	public var name: String
	public var location: URL

	public var executableUrl: URL

	public var launchCommand: String { return executableUrl.path }

	public init(name: String, location: URL)
	{
		self.name = name
		self.location = location
		executableUrl = URL(fileURLWithPath: "\(location.path)/\(name)")
	}

	public init?(json: JSON)
	{
		if let name = json["name"] as? String {
			self.name = name
		}
		else {
			return nil
		}

		if let jsonLocation = json["location"] as? String {
			location = URL(fileURLWithPath: jsonLocation)
		} else {
			location = URL(fileURLWithPath: ".")
		}

		executableUrl = URL(fileURLWithPath: "\(location.path)/\(name)")
	}

	public func toJSON() -> JSON? {
		return jsonify([
			"name" ~~> self.name,
			"location" ~~> self.location,
		])
	}
}

public extension ProcessConfig
{
	public func createProcess() -> AsyncProcess
	{
		return AsyncProcess(launchCommand)
	}

	fileprivate func verify() throws {
		guard (try? URL(fileURLWithPath: executableUrl.path).checkResourceIsReachable()) != nil else {
			throw ProcessConfigError.UnreachablePath(path: executableUrl.path)
		}
	}
}
