import 'package:faridia_healthcare/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DoctorProfilePage extends StatelessWidget {
  const DoctorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          color: AppColors.primary,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.0.sp),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.sp),
                color: AppColors.secondary.withOpacity(0.1),
              ),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 4.0.sp, horizontal: 4.sp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30.sp,
                      backgroundImage: const NetworkImage(
                          'https://g.foolcdn.com/image/?url=https%3A//g.foolcdn.com/editorial/images/64791/gettyimages-852090066_8cTQuWD.jpg&w=2000&op=resize'),
                    ),
                    SizedBox(
                      width: 8.sp,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. John Doe',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 1.sp,
                        ),
                        const Text(
                          'Dentist',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 1.sp,
                        ),
                        const Text(
                          'MBBS, BDS, MDS',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 1.sp,
                        ),
                        const Text(
                          '10 years of experience',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8.sp,
            ),
            Divider(
              color: AppColors.primary,
              thickness: 1.5.sp,
            ),
            SizedBox(
              height: 8.sp,
            ),
            Text('About',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.secondary)),
            SizedBox(
              height: 8.sp,
            ),
            SizedBox(
              height: 25.h,
              child: const Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        """Hi, I am a doctor, Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Orci nulla pellentesque dignissim enim sit. Sit amet risus nullam eget. Enim nunc faucibus a pellentesque sit amet. Cras tincidunt lobortis feugiat vivamus at. Amet mauris commodo quis imperdiet massa tincidunt. Tristique et egestas quis ipsum suspendisse ultrices gravida dictum. Turpis nunc eget lorem dolor sed viverra ipsum nunc aliquet. Ac tortor dignissim convallis aenean et tortor at. Cursus metus aliquam eleifend mi in nulla posuere sollicitudin. Vitae aliquet nec ullamcorper sit amet risus nullam eget. Pretium quam vulputate dignissim suspendisse. Nascetur ridiculus mus mauris vitae. Tristique senectus et netus et malesuada fames ac turpis.

Pellentesque massa placerat duis ultricies lacus sed turpis tincidunt. At urna condimentum mattis pellentesque id nibh tortor. Vestibulum lectus mauris ultrices eros in. Tristique et egestas quis ipsum suspendisse ultrices gravida dictum fusce. Quisque non tellus orci ac auctor augue mauris augue neque. Mi ipsum faucibus vitae aliquet nec ullamcorper sit amet risus. Ac tortor dignissim convallis aenean et tortor. Volutpat est velit egestas dui id. Quis auctor elit sed vulputate mi sit amet mauris commodo. Dictumst quisque sagittis purus sit amet volutpat consequat mauris. Phasellus egestas tellus rutrum tellus pellentesque eu tincidunt tortor. Arcu ac tortor dignissim convallis aenean et tortor. Porta nibh venenatis cras sed. Odio eu feugiat pretium nibh ipsum consequat. Enim eu turpis egestas pretium aenean.

Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Nisl nunc mi ipsum faucibus vitae. Rhoncus dolor purus non enim praesent elementum facilisis. Non nisi est sit amet facilisis magna. Facilisi cras fermentum odio eu feugiat pretium nibh ipsum consequat. Enim eu turpis egestas pretium aenean pharetra magna. Sed velit dignissim sodales ut eu. Luctus venenatis lectus magna fringilla. Egestas quis ipsum suspendisse ultrices gravida. Quam quisque id diam vel quam elementum pulvinar etiam.

Ipsum dolor sit amet consectetur adipiscing. Tristique et egestas quis ipsum suspendisse ultrices gravida. Risus viverra adipiscing at in. Metus aliquam eleifend mi in nulla posuere sollicitudin aliquam ultrices. Vel elit scelerisque mauris pellentesque pulvinar. Adipiscing elit pellentesque habitant morbi tristique senectus et netus et. Non nisi est sit amet facilisis magna. Tellus at urna condimentum mattis. Nisl condimentum id venenatis a condimentum vitae sapien pellentesque. Ac odio tempor orci dapibus ultrices in iaculis. Tempor orci eu lobortis elementum nibh tellus molestie. Sed ullamcorper morbi tincidunt ornare massa eget egestas. Non consectetur a erat nam at lectus urna duis.

Ut diam quam nulla porttitor massa id. Lectus quam id leo in. Vitae tortor condimentum lacinia quis vel. Vitae sapien pellentesque habitant morbi tristique. Consequat semper viverra nam libero justo laoreet sit. Dictumst quisque sagittis purus sit amet volutpat. Commodo viverra maecenas accumsan lacus vel facilisis volutpat est. Vestibulum mattis ullamcorper velit sed ullamcorper. Nec dui nunc mattis enim ut. Vulputate ut pharetra sit amet. Magna fermentum iaculis eu non diam phasellus vestibulum lorem sed. Gravida in fermentum et sollicitudin ac. Nulla pellentesque dignissim enim sit amet venenatis urna cursus eget. Felis imperdiet proin fermentum leo vel orci porta. Nisi porta lorem mollis aliquam. Egestas egestas fringilla phasellus faucibus scelerisque. Velit egestas dui id ornare arcu odio ut. Vitae turpis massa sed elementum tempus. Diam vulputate ut pharetra sit amet aliquam id."""),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.sp,
            ),
            Text('Services',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.secondary)),
            SizedBox(
              height: 8.sp,
            ),
            SizedBox(
              height: 25.h,
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'Dental Checkup, Dental Implant Fixing, Dental Fillings, Teeth Whitening, Teeth Cleaning, Dental Crowns, Dental Bridges, Dental X-Ray, Dental Braces Fixing, Dental Examinations, Dental Restoration, Dental Sealant, Dental Implants, Dental Prophylaxis, Dental Ceramics, Dental Surgery, Dental Examinations, Dental Restoration, Dental Sealant, Dental Implants, Dental Prophylaxis, Dental Ceramics, Dental Surgery',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: AppColors.secondary.withOpacity(0.7))),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.sp,
            ),
            Text('Education',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.secondary)),
            SizedBox(
              height: 8.sp,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'BDS - Saveetha Dental College and Hospital, Chennai, 2009',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: AppColors.secondary.withOpacity(0.7))),
            ),
            SizedBox(
              height: 8.sp,
            ),
            Text('Experience',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.secondary)),
            SizedBox(
              height: 8.sp,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  '2010 - 2011  Dental Surgeon at Dr. Srinivasan Dental Clinic',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: AppColors.secondary.withOpacity(0.7))),
            ),
            SizedBox(
              height: 8.sp,
            ),
            Text('Awards and Recognitions',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.secondary)),
            SizedBox(
              height: 8.sp,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'Best Dentist Award - 2011, Best Dentist Award - 2012, Best Dentist Award - 2013',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: AppColors.secondary.withOpacity(0.7))),
            ),
            SizedBox(
              height: 8.sp,
            ),
            Text('Clinic Address',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.secondary)),
            SizedBox(
              height: 8.sp,
            ),
            Text('Dr. Srinivasan Dental Clinic',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: AppColors.secondary.withOpacity(0.7))),
            Divider(
              thickness: 1.5.sp,
              color: AppColors.primary,
            ),
            SizedBox(
              height: 8.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                  onPressed: () {},
                  label: Row(
                    children: [
                      const Icon(Icons.bookmark),
                      SizedBox(
                        width: 5.sp,
                      ),
                      Text(
                        'Save this Doctor',
                        style: TextStyle(fontSize: 12.sp),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8.sp,
            ),
          ],
        ),
      ),
    );
  }
}
