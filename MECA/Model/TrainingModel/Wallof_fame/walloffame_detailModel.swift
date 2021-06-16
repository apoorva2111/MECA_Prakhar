//
//  walloffame_detailModel.swift
//  MECA
//
//  Created by Macbook  on 03/06/21.
//

import Foundation
struct walloffame_detailModel : Codable {
    let frame: Int?
        let country: String?
        let courseStatus: Int?
        let courseDate: String?
        let step1Status: Int?
        let step1Date: String?
        let step13_Status: Int?
        let step13_Date: String?
        let step15_Status: Int?
        let step15_Date: String?
        let finalReportStatus: Int?
        let finalReportDate: String?
        let mentorPassedStatus: Int?
        let mentorPassedDate, mentorExperience, gradeAndYear, displayName: String?
        let companyName, profession, avatar: String?

    enum CodingKeys : String , CodingKey {
        case frame = "frame"
            case  country = "country"
                case courseStatus = "course_status"
                case courseDate = "course_date"
                case step1Status = "step1_status"
                case step1Date = "step1_date"
                case step13_Status = "step1_3_status"
                case step13_Date = "step1_3_date"
                case step15_Status = "step1_5_status"
                case step15_Date = "step1_5_date"
                case finalReportStatus = "final_report_status"
                case finalReportDate = "final_report_date"
                case mentorPassedStatus = "mentor_passed_status"
                case mentorPassedDate = "mentor_passed_date"
                case mentorExperience = "mentor_experience"
                case gradeAndYear = "grade_and_year"
                case displayName = "display_name"
                case companyName = "company_name"
                case avatar = "avatar"
                case profession = "profession"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        frame = try values.decodeIfPresent(Int.self, forKey: .frame)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        courseStatus = try values.decodeIfPresent(Int.self, forKey: .courseStatus)
        courseDate = try values .decodeIfPresent(String.self, forKey: .courseDate)
        step1Status = try values.decodeIfPresent(Int.self, forKey: .step1Status)
        step1Date = try values.decodeIfPresent(String.self, forKey: .step1Date)
        step13_Status = try values.decodeIfPresent(Int.self, forKey: .step13_Status)
        step13_Date = try values.decodeIfPresent(String.self, forKey: .step13_Date)
        step15_Status = try values.decodeIfPresent(Int.self, forKey: .step15_Status)
        step15_Date = try values.decodeIfPresent(String.self, forKey: .step15_Date)
        finalReportStatus = try values.decodeIfPresent(Int.self, forKey: .finalReportStatus)
        finalReportDate = try values.decodeIfPresent(String.self, forKey: .finalReportDate)
        mentorPassedStatus = try values.decodeIfPresent(Int.self, forKey: .mentorPassedStatus)
        mentorPassedDate = try values.decodeIfPresent(String.self, forKey: .mentorPassedDate)
        mentorExperience = try values.decodeIfPresent(String.self, forKey: .mentorExperience)
        gradeAndYear = try values.decodeIfPresent(String.self, forKey: .gradeAndYear)
        displayName = try values.decodeIfPresent(String.self, forKey: .displayName)
        companyName = try values.decodeIfPresent(String.self, forKey: .companyName)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        profession = try values.decodeIfPresent(String.self, forKey: .profession)

    }

}

//import Foundation
//public class walloffame_detailModel {
//
//            var frame: Int?
//    var country: String?
//    var courseStatus: Int?
//    var courseDate: String?
//    var step1Status: Int?
//    var step1Date: String?
//    var step13_Status: Int?
//    var step13_Date: String?
//    var step15_Status: Int?
//    var step15_Date: String?
//    var finalReportStatus: Int?
//    var finalReportDate: String?
//    var mentorPassedStatus: Int?
//    var mentorPassedDate, mentorExperience, gradeAndYear, displayName: String?
//    var companyName, profession, avatar: String?
//
//
//
//    init(frame: Int?, country: String?, courseStatus:Int?,courseDate:String?,step1Status:Int?,step1Date:String?,step13_Status:Int?,step13_Date:String?, step15_Status:Int?,step15_Date: String?,finalReportStatus:Int?,finalReportDate:String?,mentorPassedStatus: Int?, mentorPassedDate:String?, mentorExperience:String?,gradeAndYear:String?, displayName:String?,companyName:String?,profession: strin) {
//        self.user_name = user_name
//        self.avatar = avatar
//        self.fileurl = fileurl
//        self.created_at = created_at
//        self.step1Status = step1Status
//        self.step1Date = step1Date
//        self.step13_Status = step13_Status
//        self.step13_Date = step13_Date
//        self.step15_Status = step15_Status
//        self.step15_Date = step15_Date
//        self.finalReportStatus = finalReportStatus
//        self.finalReportDate = finalReportDate
//        self.mentorPassedStatus = mentorPassedStatus
//        self.mentorPassedDate = mentorPassedDate
//        self.mentorExperience = mentorExperience
//        self.gradeAndYear = gradeAndYear
//        self.displayName = displayName
//        self.companyName = companyName
//    }
//
//
//
//
//
//}
