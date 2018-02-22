pragma solidity ^0.4.11;

library cvSections {

    struct Profile {
        string _name; string _title; string _summary; string _website; string _phone; string _email;string _description;
    }
    struct Role {
        string _company; string _Role; string _startDate; string _endDate; string _summary; string _highlights;
    }
    struct Education {
        string _institution; string _focusArea; int32 _startYear; int32 _finishYear;
    }
    struct Project {
        string name; string link; string description;
    }
    struct Publication {
        string name; string link; string language;
    }
    struct Skill {
        string name; int32 level;
    }
	
}




contract cvContract {
    mapping (string => string) Profile;
    address owner;

    cvSections.Project[] public projects;
    cvSections.Education[] public educations;
    cvSections.Skill[] public skills;
    cvSections.Publication[] public publications;

    // =====================
    // ==== CONSTRUCTOR ====
    // =====================
    function cvContract() public{
        owner =  msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    // =============================
    // ====== ADD NEW PROFILE ======
    // =============================

    function setProfileData (string key, string value) public onlyOwner() {
        Profile[key] = value;
    }

    function editProfileData (string key, string value) public onlyOwner() {
        Profile[key] = value;
    }

    function editProject (
        bool operation,
        string name,
        string link,
        string description
    ) public onlyOwner() {
        if (operation) {
            projects.push(cvSections.Project(name, description, link));
        } else {
            delete projects[projects.length - 1];
        }
    }

    function editEducation (
        bool operation,
        string name,
        string speciality,
        int32 year_start,
        int32 year_finish
    ) public onlyOwner() {
        if (operation) {
            educations.push(cvSections.Education(name, speciality, year_start, year_finish));
        } else {
            delete educations[educations.length - 1];
        }
    }

    function editSkill(bool operation, string name, int32 level) public onlyOwner() {
        if (operation) {
            skills.push(cvSections.Skill(name, level));
        } else {
            delete skills[skills.length - 1];
        }
    }

    function editPublication (bool operation, string name, string link, string language) public onlyOwner() {
        if (operation) {
            publications.push(cvSections.Publication(name, link, language));
        } else {
            delete publications[publications.length - 1];
        }
    }

    // ======================================
    // ======= Retriving Profile data =======
    // ======================================
    function getProfileData (string arg) public constant returns (string) {
        return Profile[arg];
    }

    function getSize(string arg) public view returns (uint) {
        if (keccak256(arg) == keccak256("projects")) { return projects.length; }
        if (keccak256(arg) == keccak256("educations")) { return educations.length; }
        if (keccak256(arg) == keccak256("publications")) { return publications.length; }
        if (keccak256(arg) == keccak256("skills")) { return skills.length; }
        revert();
    }
}
