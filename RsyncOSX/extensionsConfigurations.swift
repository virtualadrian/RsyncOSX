//
//  extensionsConfigurations.swift
//  RsyncOSX
//
//  Created by Thomas Evensen on 24.08.2018.
//  Copyright © 2018 Thomas Evensen. All rights reserved.
//

import Foundation
import Cocoa

// Protocol for returning object Configurations
protocol GetConfigurationsObject: class {
    func getconfigurationsobject() -> Configurations?
    func createconfigurationsobject(profile: String?) -> Configurations?
    func reloadconfigurationsobject()
}

protocol SetConfigurations {
    var configurationsDelegate: GetConfigurationsObject? { get }
}

extension SetConfigurations {
    var configurationsDelegate: GetConfigurationsObject? {
        return ViewControllerReference.shared.getvcref(viewcontroller: .vctabmain) as? ViewControllertabMain
    }
    var configurations: Configurations? {
        return self.configurationsDelegate?.getconfigurationsobject()
    }
}

// Protocol for doing a refresh of tabledata
protocol Reloadandrefresh: class {
    func reloadtabledata()
}

protocol ReloadTable {
    var reloadDelegateMain: Reloadandrefresh? { get }
    var reloadDelegateSchedule: Reloadandrefresh? { get }
    var reloadDelegateLoggData: Reloadandrefresh? { get }
    var reloadDelegateSnapshot: Reloadandrefresh? { get }
}

extension ReloadTable {
    var reloadDelegateMain: Reloadandrefresh? {
        return ViewControllerReference.shared.getvcref(viewcontroller: .vctabmain) as? ViewControllertabMain
    }
    var reloadDelegateSchedule: Reloadandrefresh? {
        return ViewControllerReference.shared.getvcref(viewcontroller: .vctabschedule) as? ViewControllertabSchedule
    }
    var reloadDelegateLoggData: Reloadandrefresh? {
        return ViewControllerReference.shared.getvcref(viewcontroller: .vcloggdata) as? ViewControllerLoggData
    }
    var reloadDelegateSnapshot: Reloadandrefresh? {
        return ViewControllerReference.shared.getvcref(viewcontroller: .vcsnapshot) as? ViewControllerSnapshots
    }

    func reloadtable(vcontroller: ViewController) {
        if vcontroller == .vctabmain {
            self.reloadDelegateMain?.reloadtabledata()
        } else if vcontroller == .vctabschedule {
            self.reloadDelegateSchedule?.reloadtabledata()
        } else if vcontroller == .vcloggdata {
            self.reloadDelegateLoggData?.reloadtabledata()
        } else if vcontroller == .vcsnapshot {
            self.reloadDelegateSnapshot?.reloadtabledata()
        }
    }
}

// Used to select argument
enum ArgumentsRsync {
    case arg
    case argdryRun
    case argdryRunlocalcataloginfo
}

// Enum which resource to return
enum ResourceInConfiguration {
    case remoteCatalog
    case localCatalog
    case offsiteServer
    case task
    case backupid
    case offsiteusername
    case sshport
}
