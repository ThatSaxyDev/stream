part of 'base_nav_view.dart';

//! the state notifier provider for controlling the state of the base nav wrapper
final baseNavControllerProvider =
    StateNotifierProvider<BaseNavController, int>((ref) {
  return BaseNavController();
});

//! the state notifier class for controlling the state of the base nav wrapper
class BaseNavController extends StateNotifier<int> {
  BaseNavController() : super(0);

  //! move to page
  void moveToPage({required int index}) {
    state = index;
  }
}

//! () => move to page
void moveToPage({
  required BuildContext context,
  required WidgetRef ref,
  required int index,
}) {
  ref.read(baseNavControllerProvider.notifier).moveToPage(index: index);
}

//! List of pages
List<Widget> pages = [
  const HomeFeedView(),
  const SearchView(),
  const NotificationsView(),
  const ProfileView(),
];

//! nav widget enums
enum Nav {
  home(PhosphorIconsRegular.houseSimple, PhosphorIconsFill.houseSimple),
  search(
      PhosphorIconsRegular.magnifyingGlass, PhosphorIconsFill.magnifyingGlass),
  stream(PhosphorIconsRegular.pen, PhosphorIconsRegular.pen),
  notification(
      PhosphorIconsRegular.notification, PhosphorIconsFill.notification),
  profile(PhosphorIconsRegular.user, PhosphorIconsFill.user);

  const Nav(
    this.icon,
    this.selectedIcon,
  );
  final IconData icon;
  final IconData selectedIcon;
}

List<Nav> nav = [
  Nav.home,
  Nav.search,
  Nav.stream,
  Nav.notification,
  Nav.profile,
];
