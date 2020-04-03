// This listener responds to a highlander hook in the game which asks for an equipped PCS icon
class OnGetPCSImageListener extends X2EventListener config(PCSImages);


struct PCSImage {
    var name Name;
    var string Image;
};
var config array<PCSImage> ImageMap;


static function array<X2DataTemplate> CreateTemplates() {
    local array<X2DataTemplate> t;
    t.AddItem(CreateOnGetPCSImageListener());
    return t;
}


static function CHEventListenerTemplate CreateOnGetPCSImageListener() {
    local CHEventListenerTemplate t;
    `CREATE_X2TEMPLATE(class'CHEventListenerTemplate', t, 'OnGetPCSImageListener');
    t.RegisterInStrategy = true;
    t.AddCHEvent('OnGetPCSImage', OnGetPCSImageFn, ELD_Immediate, 50);
    return t;
}


static function EventListenerReturn OnGetPCSImageFn(Object EventData, Object EventSource, XComGameState NewGameState, Name Event, Object CallbackData) {
    local XComGameState_Item item;
    local PCSImage img;

    item = XComGameState_Item(XComLWTuple(EventData).Data[0].o);

    foreach default.ImageMap(img) {
        if(img.Name == item.GetMyTemplateName()) {
            XComLWTuple(EventData).Data[1].s = img.Image;
            break;
        }
    }

    return ELR_NoInterrupt;
}
