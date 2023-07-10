class VolunteerRequestSendRequest{
    String name;
    String phone;
    String email;
    String about;

    VolunteerRequestSendRequest({
        this.name,
        this.phone,
        this.email,
        this.about
    });
}

class AthleteRequestSendRequest{
    String name;
    String age;
    String disability;
    String phone;
    String email;
    String municipality;
    String sport;

    AthleteRequestSendRequest({
        this.name,
        this.age,
        this.disability,
        this.phone,
        this.email,
        this.municipality,
        this.sport
    });
}

class PartnerRequestSendRequest{
    String name;
    String age;
    String phone;
    String email;
    String municipality;
    String sport;

    PartnerRequestSendRequest({
        this.name,
        this.age,
        this.phone,
        this.email,
        this.municipality,
        this.sport
    });
}

class FamilyRequestSendRequest{
    String name;
    String relationship;
    String disability;
    String phone;
    String email;
    String municipality;

    FamilyRequestSendRequest({
        this.name,
        this.relationship,
        this.disability,
        this.phone,
        this.email,
        this.municipality
    });
}

class ProfessionalRequestSendRequest{
    String name;
    String phone;
    String email;
    String about;
    String services;

    ProfessionalRequestSendRequest({
        this.name,
        this.phone,
        this.email,
        this.about,
        this.services
    });
}

class CoachRequestSendRequest{
    String name;
    String phone;
    String email;
    String about;
    String sports;
    String municipalities;

    CoachRequestSendRequest({
        this.name,
        this.phone,
        this.email,
        this.about,
        this.sports,
        this.municipalities
    });
}