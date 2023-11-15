from tasks.map.control.waypoint import Waypoint
from tasks.map.keywords.plane import Luofu_StargazerNavalia
from tasks.map.route.base import locked_position
from tasks.rogue.route.base import RouteBase


class Route(RouteBase):

    @locked_position
    def Luofu_StargazerNavalia_F1_X250Y498(self):
        """
        | Waypoint | Position                  | Direction | Rotation |
        | -------- | ------------------------- | --------- | -------- |
        | spawn    | Waypoint((249.4, 498.5)), | 190.1     | 184      |
        | event    | Waypoint((236.8, 528.9)), | 188.1     | 181      |
        | exit_    | Waypoint((245.3, 550.1)), | 282.9     | 181      |
        """
        self.map_init(plane=Luofu_StargazerNavalia, floor="F1", position=(249.4, 498.5))
        self.register_domain_exit(Waypoint((245.3, 550.1)), end_rotation=181)
        event = Waypoint((236.8, 528.9))

        self.clear_event(event)
        # ===== End of generated waypoints =====

    @locked_position
    def Luofu_StargazerNavalia_F1_X521Y595(self):
        """
        | Waypoint       | Position                  | Direction | Rotation |
        | -------------- | ------------------------- | --------- | -------- |
        | spawn          | Waypoint((521.6, 595.4)), | 190.1     | 184      |
        | item_X504Y610  | Waypoint((504.0, 610.0)), | 188.9     | 186      |
        | event_X510Y626 | Waypoint((510.6, 626.4)), | 282.9     | 181      |
        | exit_          | Waypoint((522.2, 630.6)), | 190.0     | 184      |
        | exit1          | Waypoint((528.2, 636.2)), | 180.0     | 179      |
        | exit2          | Waypoint((516.0, 636.2)), | 180.0     | 179      |
        """
        self.map_init(plane=Luofu_StargazerNavalia, floor="F1", position=(521.6, 595.4))
        self.register_domain_exit(
            Waypoint((522.2, 630.6)), end_rotation=184,
            left_door=Waypoint((528.2, 636.2)), right_door=Waypoint((516.0, 636.2)))
        item_X504Y610 = Waypoint((504.0, 610.0))
        event_X510Y626 = Waypoint((510.6, 626.4))

        self.clear_item(item_X504Y610)
        self.clear_event(event_X510Y626)
        # ===== End of generated waypoints =====
