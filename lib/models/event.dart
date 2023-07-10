class EventIndexResponseItem{
    int id;
    String name;
    DateTime start;
    DateTime end;

    EventIndexResponseItem({
        this.id,
        this.name,
        this.start,
        this.end
    });
}

class EventShowResponse{
    String name;
    String description;
    DateTime start;
    DateTime end;
    String location;
    String contactEmail;
    int type;
    int athletes;
    int volunteers;
    int galleryId;

    EventShowResponse({
        this.name,
        this.description,
        this.start,
        this.end,
        this.location,
        this.contactEmail,
        this.type,
        this.athletes,
        this.volunteers,
        this.galleryId
    });
}